//
//  CollectionDetailsViewModel.swift
//  RijksMuseum
//
//  Created by Alessio Roberto on 12/05/22.
//

import Foundation

final class CollectionDetailsViewModel {
    private let service: CollectionDetailsRequesting
    private let objectNumber: String
    private var model: CollectionModel?

    private let imagePool = ImagePool(limit: 10)

    private let imageLoadingQueue: OperationQueue = {
        let result = OperationQueue()
        result.underlyingQueue = .global(qos: .default)
        result.maxConcurrentOperationCount = 20

        return result
    }()

    private let dataLoadingQueue: OperationQueue = {
        let result = OperationQueue()
        result.underlyingQueue = .global(qos: .default)
        result.maxConcurrentOperationCount = 1

        return result
    }()

    /// Full screen reload event handler
    var onReload: ((CollectionModel) -> Void)?

    /// Designated initializer
    /// - Parameter service: Collection Details service
    /// - Parameter objectNumber: ArtObject number
    init(service: CollectionDetailsRequesting, objectNumber: String) {
        self.service = service
        self.objectNumber = objectNumber
    }

    /// Handles view loading completion event
    func onViewLoad() {
        //        isActivityIndicatorAnimating = true
        loadDetails()
    }

    // MARK: - Private

    private func loadDetails() {
        guard dataLoadingQueue.operationCount == 0 else { return }

        let operation = SyncOperation { [weak self] in
            self?.getDetails()
        } completion: { [weak self] result in
            guard let result = result else { return }
            self?.handleImage(result)
        }

        dataLoadingQueue.addOperation(operation)
    }

    private func getDetails() -> Result<(title: String, url: String), Error>? {
        var result: Result<(title: String, url: String), Error>?

        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()

        service.getImage(ofObjectNumber: objectNumber) { res in
            result = res
            dispatchGroup.leave()
        }

        dispatchGroup.wait()

        return result
    }

    private func handleImage(_ result: Result<(title: String, url: String), Error>) {
        if case let .success(data) = result {
            DispatchQueue.main.async { [weak self] in
                guard let self = self,
                      let url = URL(string: data.url) else { return }

                let imageLoader = ImageLoader(queue: self.imageLoadingQueue, url: url, cache: self.imagePool)
                self.model = CollectionModel(objectNumber: "",
                                             imageLoader: imageLoader,
                                             imageTitle: data.title,
                                             loadingTitle: "",
                                             failureTitle: "")
                if let model = self.model {
                    self.onReload?(model)
                }
            }
        } else {
            DispatchQueue.main.async {
                //                self.isActivityIndicatorAnimating = false
                //                self.collection = []
                //                self.onReload?()
            }
        }
    }
}
