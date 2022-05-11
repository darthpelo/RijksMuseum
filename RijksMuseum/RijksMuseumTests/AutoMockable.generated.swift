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

class CollectionRequestingMock: CollectionRequesting {
    // MARK: - getImages

    var getImagesMaxResultsForPageCallsCount = 0
    var getImagesMaxResultsForPageCalled: Bool {
        getImagesMaxResultsForPageCallsCount > 0
    }

    var getImagesMaxResultsForPageReceivedArguments: (maxCount: Int, page: Int, completion: (Result<[(title: String, url: String)], Error>) -> Void)?
    var getImagesMaxResultsForPageReceivedInvocations: [(maxCount: Int, page: Int, completion: (Result<[(title: String, url: String)], Error>) -> Void)] = []
    var getImagesMaxResultsForPageClosure: ((Int, Int, @escaping (Result<[(title: String, url: String)], Error>) -> Void) -> Void)?

    func getImages(maxResults maxCount: Int, forPage page: Int, _ completion: @escaping (Result<[(title: String, url: String)], Error>) -> Void) {
        getImagesMaxResultsForPageCallsCount += 1
        getImagesMaxResultsForPageReceivedArguments = (maxCount: maxCount, page: page, completion: completion)
        getImagesMaxResultsForPageReceivedInvocations.append((maxCount: maxCount, page: page, completion: completion))
        getImagesMaxResultsForPageClosure?(maxCount, page, completion)
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
