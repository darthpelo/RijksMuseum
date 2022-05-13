// Generated using Sourcery 1.8.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
    import UIKit
#elseif os(OSX)
    import AppKit
#endif

@testable import RijksMuseum

class CollectionDetailsPresentableMock: CollectionDetailsPresentable {
    // MARK: - setTitle

    var setTitleCallsCount = 0
    var setTitleCalled: Bool {
        setTitleCallsCount > 0
    }

    var setTitleReceivedTitle: String?
    var setTitleReceivedInvocations: [String] = []
    var setTitleClosure: ((String) -> Void)?

    func setTitle(_ title: String) {
        setTitleCallsCount += 1
        setTitleReceivedTitle = title
        setTitleReceivedInvocations.append(title)
        setTitleClosure?(title)
    }

    // MARK: - setImage

    var setImageCallsCount = 0
    var setImageCalled: Bool {
        setImageCallsCount > 0
    }

    var setImageReceivedImage: UIImage?
    var setImageReceivedInvocations: [UIImage] = []
    var setImageClosure: ((UIImage) -> Void)?

    func setImage(_ image: UIImage) {
        setImageCallsCount += 1
        setImageReceivedImage = image
        setImageReceivedInvocations.append(image)
        setImageClosure?(image)
    }
}

class CollectionDetailsRequestingMock: CollectionDetailsRequesting {
    // MARK: - getImage

    var getImageOfObjectNumberCallsCount = 0
    var getImageOfObjectNumberCalled: Bool {
        getImageOfObjectNumberCallsCount > 0
    }

    var getImageOfObjectNumberReceivedArguments: (objectNumber: String, completion: (Result<(title: String, url: String), Error>) -> Void)?
    var getImageOfObjectNumberReceivedInvocations: [(objectNumber: String, completion: (Result<(title: String, url: String), Error>) -> Void)] = []
    var getImageOfObjectNumberClosure: ((String, @escaping (Result<(title: String, url: String), Error>) -> Void) -> Void)?

    func getImage(ofObjectNumber objectNumber: String, _ completion: @escaping (Result<(title: String, url: String), Error>) -> Void) {
        getImageOfObjectNumberCallsCount += 1
        getImageOfObjectNumberReceivedArguments = (objectNumber: objectNumber, completion: completion)
        getImageOfObjectNumberReceivedInvocations.append((objectNumber: objectNumber, completion: completion))
        getImageOfObjectNumberClosure?(objectNumber, completion)
    }
}

class CollectionPresentableMock: CollectionPresentable {
    // MARK: - setTitle

    var setTitleCallsCount = 0
    var setTitleCalled: Bool {
        setTitleCallsCount > 0
    }

    var setTitleReceivedTitle: String?
    var setTitleReceivedInvocations: [String] = []
    var setTitleClosure: ((String) -> Void)?

    func setTitle(_ title: String) {
        setTitleCallsCount += 1
        setTitleReceivedTitle = title
        setTitleReceivedInvocations.append(title)
        setTitleClosure?(title)
    }

    // MARK: - setImage

    var setImageCallsCount = 0
    var setImageCalled: Bool {
        setImageCallsCount > 0
    }

    var setImageReceivedImage: UIImage?
    var setImageReceivedInvocations: [UIImage] = []
    var setImageClosure: ((UIImage) -> Void)?

    func setImage(_ image: UIImage) {
        setImageCallsCount += 1
        setImageReceivedImage = image
        setImageReceivedInvocations.append(image)
        setImageClosure?(image)
    }

    // MARK: - setPlaceholder

    var setPlaceholderCallsCount = 0
    var setPlaceholderCalled: Bool {
        setPlaceholderCallsCount > 0
    }

    var setPlaceholderClosure: (() -> Void)?

    func setPlaceholder() {
        setPlaceholderCallsCount += 1
        setPlaceholderClosure?()
    }

    // MARK: - setOnPrepareForReuse

    var setOnPrepareForReuseCallsCount = 0
    var setOnPrepareForReuseCalled: Bool {
        setOnPrepareForReuseCallsCount > 0
    }

    var setOnPrepareForReuseReceivedOnPrepareForReuse: (() -> Void)?
    var setOnPrepareForReuseReceivedInvocations: [() -> Void] = []
    var setOnPrepareForReuseClosure: ((@escaping () -> Void) -> Void)?

    func setOnPrepareForReuse(_ onPrepareForReuse: @escaping () -> Void) {
        setOnPrepareForReuseCallsCount += 1
        setOnPrepareForReuseReceivedOnPrepareForReuse = onPrepareForReuse
        setOnPrepareForReuseReceivedInvocations.append(onPrepareForReuse)
        setOnPrepareForReuseClosure?(onPrepareForReuse)
    }
}

class CollectionRequestingMock: CollectionRequesting {
    // MARK: - getImages

    var getImagesOfMaxResultsForPageCallsCount = 0
    var getImagesOfMaxResultsForPageCalled: Bool {
        getImagesOfMaxResultsForPageCallsCount > 0
    }

    var getImagesOfMaxResultsForPageReceivedArguments: (maxCount: Int, page: Int, completion: (Result<[ArtObjectData], Error>) -> Void)?
    var getImagesOfMaxResultsForPageReceivedInvocations: [(maxCount: Int, page: Int, completion: (Result<[ArtObjectData], Error>) -> Void)] = []
    var getImagesOfMaxResultsForPageClosure: ((Int, Int, @escaping (Result<[ArtObjectData], Error>) -> Void) -> Void)?

    func getImages(ofMaxResults maxCount: Int, forPage page: Int, _ completion: @escaping (Result<[ArtObjectData], Error>) -> Void) {
        getImagesOfMaxResultsForPageCallsCount += 1
        getImagesOfMaxResultsForPageReceivedArguments = (maxCount: maxCount, page: page, completion: completion)
        getImagesOfMaxResultsForPageReceivedInvocations.append((maxCount: maxCount, page: page, completion: completion))
        getImagesOfMaxResultsForPageClosure?(maxCount, page, completion)
    }
}

class CollectionRoutingMock: CollectionRouting {
    // MARK: - showCollection

    var showCollectionCallsCount = 0
    var showCollectionCalled: Bool {
        showCollectionCallsCount > 0
    }

    var showCollectionReceivedOnCompletion: ((String) -> Void)?
    var showCollectionReceivedInvocations: [(String) -> Void] = []
    var showCollectionClosure: ((@escaping (String) -> Void) -> Void)?

    func showCollection(_ onCompletion: @escaping (String) -> Void) {
        showCollectionCallsCount += 1
        showCollectionReceivedOnCompletion = onCompletion
        showCollectionReceivedInvocations.append(onCompletion)
        showCollectionClosure?(onCompletion)
    }

    // MARK: - showDetails

    var showDetailsObjectNumberCallsCount = 0
    var showDetailsObjectNumberCalled: Bool {
        showDetailsObjectNumberCallsCount > 0
    }

    var showDetailsObjectNumberReceivedObjectNumber: String?
    var showDetailsObjectNumberReceivedInvocations: [String] = []
    var showDetailsObjectNumberClosure: ((String) -> Void)?

    func showDetails(objectNumber: String) {
        showDetailsObjectNumberCallsCount += 1
        showDetailsObjectNumberReceivedObjectNumber = objectNumber
        showDetailsObjectNumberReceivedInvocations.append(objectNumber)
        showDetailsObjectNumberClosure?(objectNumber)
    }
}

class ImageLoadingMock: ImageLoading {
    // MARK: - loadImage

    var loadImageOnSuccessOnFailureCallsCount = 0
    var loadImageOnSuccessOnFailureCalled: Bool {
        loadImageOnSuccessOnFailureCallsCount > 0
    }

    var loadImageOnSuccessOnFailureReceivedArguments: (onSuccess: (UIImage) -> Void, onFailure: (() -> Void)?)?
    var loadImageOnSuccessOnFailureReceivedInvocations: [(onSuccess: (UIImage) -> Void, onFailure: (() -> Void)?)] = []
    var loadImageOnSuccessOnFailureClosure: ((@escaping (UIImage) -> Void, (() -> Void)?) -> Void)?

    func loadImage(onSuccess: @escaping (UIImage) -> Void, onFailure: (() -> Void)?) {
        loadImageOnSuccessOnFailureCallsCount += 1
        loadImageOnSuccessOnFailureReceivedArguments = (onSuccess: onSuccess, onFailure: onFailure)
        loadImageOnSuccessOnFailureReceivedInvocations.append((onSuccess: onSuccess, onFailure: onFailure))
        loadImageOnSuccessOnFailureClosure?(onSuccess, onFailure)
    }

    // MARK: - cancelLoading

    var cancelLoadingCallsCount = 0
    var cancelLoadingCalled: Bool {
        cancelLoadingCallsCount > 0
    }

    var cancelLoadingClosure: (() -> Void)?

    func cancelLoading() {
        cancelLoadingCallsCount += 1
        cancelLoadingClosure?()
    }
}
