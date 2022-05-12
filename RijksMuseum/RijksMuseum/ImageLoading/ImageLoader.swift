import UIKit

/// Remote image loader
public final class ImageLoader: ImageLoading {
    private var operation: Operation?

    private let queue: OperationQueue
    private let url: URL
    private let cache: ImageCaching

    /// Designated initializer
    /// - Parameter queue: Tasks queue
    /// - Parameter url: Image URL
    /// - Parameter cache: Images cache
    public init(
        queue: OperationQueue,
        url: URL,
        cache: ImageCaching
    ) {
        self.queue = queue
        self.url = url
        self.cache = cache
    }

    public func loadImage(onSuccess: @escaping (UIImage) -> Void, onFailure: (() -> Void)?) {
        cancelLoading()

        if let image = cache.image(forUrl: url) {
            onSuccess(image)
            return
        }

        let operation = SyncOperation { [url] in
            try? Data(contentsOf: url)
        } completion: { [weak self] data in
            if let self = self,
               let data = data,
               let image = UIImage(data: data)
            {
                ImageCompressor.compress(image: image, maxByte: 2_000_000) { [weak self] image in
                    guard let self = self,
                          let compressedImage = image
                    else {
                        onFailure?()
                        return
                    }
                    self.cache.storeImage(compressedImage, byUrl: self.url)
                    onSuccess(compressedImage)
                }
            } else {
                onFailure?()
            }
        }

        queue.addOperation(operation)
        self.operation = operation
    }

    public func cancelLoading() {
        if let operation = operation, operation.isExecuting {
            operation.cancel()
        }
    }
}
