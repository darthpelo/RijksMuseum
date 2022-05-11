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
