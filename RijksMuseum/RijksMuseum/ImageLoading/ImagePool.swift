import UIKit

/// Restricted-size image cache
public final class ImagePool: ImageCaching {
    static let shared = ImagePool(limit: 100)

    private var innerStorage: [URL: UIImage] = [:]
    private let limit: UInt

    private var storage: [URL: UIImage] {
        get {
            var result: [URL: UIImage] = [:]

            isolationQueue.sync {
                result = innerStorage
            }

            return result
        }
        set {
            isolationQueue.async(flags: .barrier) {
                self.innerStorage = newValue
            }
        }
    }

    private let isolationQueue = DispatchQueue(label: "com.alessioroberto.imagepool", attributes: .concurrent)

    /// Storage size limit
    public init(limit: UInt) {
        self.limit = limit
    }

    public func storeImage(_ image: UIImage, byUrl url: URL) {
        guard storage[url] == nil else { return }

        if limit <= storage.count, let firstKey = storage.first?.key {
            storage[firstKey] = nil
        }

        storage[url] = image
    }

    public func image(forUrl url: URL) -> UIImage? {
        storage[url]
    }
}
