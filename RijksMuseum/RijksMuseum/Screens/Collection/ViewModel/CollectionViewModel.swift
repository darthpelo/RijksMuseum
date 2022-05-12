//
//  CollectionViewModel.swift
//  RijksMuseum
//
//  Created by Alessio Roberto on 12/05/22.
//

import UIKit

/// Collection screen business-logic
final class CollectionViewModel {
    /// Number of columns in each row
    let columnsCount: Int = 2

    /// Collection list placeholder title label text
    let placeholderTitle: String = "No results"

    /// Pull-to-refresh indicator deactivation event handler
    var onPullToRefreshDeactivation: (() -> Void)?

    /// Full screen reload event handler
    var onReload: (() -> Void)?

    /// New sections insertion event handler
    var onSectionsInsertion: ((IndexSet) -> Void)?

    /// Activity indicator animating state
    @Observable
    private(set) var isActivityIndicatorAnimating: Bool = false

    /// Collection list placeholder visibility indicator
    @Observable
    private(set) var isPlaceholderHidden: Bool = false

    /// Collection model
    private(set) var collection: [CollectionModel] = [] {
        didSet {
            isPlaceholderHidden = !collection.isEmpty
        }
    }

    private var currentPage: Int = 1
    private var pageSize: Int = 10

    private let imagePool = ImagePool(limit: 100)

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

    private let service: CollectionRequesting
    private let router: CollectionRouting

    /// Designated initializer
    /// - Parameter service: Collection service
    /// - Parameter router: Router
    init(service: CollectionRequesting, router: CollectionRouting) {
        self.service = service
        self.router = router
    }

    /// Handles view loading completion event
    func onViewLoad() {
        loadNextPage()
    }

    /// Handles user reaching the bottom of the scroll event
    func onBottomDragging() {
        loadNextPage()
    }

    /// Handles user using pull-to-refresh event
    func onPullToRefresh() {
        dataLoadingQueue.cancelAllOperations()
        currentPage = 1
        loadNextPage()
    }

    // MARK: - Private

    private func loadNextPage() {
        guard dataLoadingQueue.operationCount == 0 else { return }
        onPullToRefreshDeactivation?()

        let operation = SyncOperation { [weak self] in
            self?.getImages()
        } completion: { [weak self] result in
            guard let result = result else { return }
            self?.handleImages(result)
        }

        dataLoadingQueue.addOperation(operation)
    }

    private func getImages() -> Result<[(title: String, url: String)], Error>? {
        var result: Result<[(title: String, url: String)], Error>?

        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()

        service.getImages(ofMaxResults: pageSize, forPage: currentPage) { res in
            result = res
            dispatchGroup.leave()
        }

        dispatchGroup.wait()

        return result
    }

    private func handleImages(_ result: Result<[(title: String, url: String)], Error>) {
        if case let .success(data) = result {
            DispatchQueue.main.async {
                self.appendNewImages(data)
            }
        } else if currentPage == 1 {
            DispatchQueue.main.async {
                self.collection = []
                self.onReload?()
            }
        }
    }

    private func appendNewImages(_ data: [(title: String, url: String)]) {
        isActivityIndicatorAnimating = false
        onPullToRefreshDeactivation?()

        let newCollection: [CollectionModel] = data.compactMap {
            guard let url = URL(string: $0.url) else { return nil }

            let imageLoader = ImageLoader(queue: imageLoadingQueue, url: url, cache: imagePool)
            let model = CollectionModel(
                imageLoader: imageLoader,
                imageTitle: $0.title,
                loadingTitle: "Loading",
                failureTitle: "Failed to load image\nPress to retry"
            )

            return model
        }

        let firstNewSectionIndex = ((currentPage - 1) * pageSize) / columnsCount

        let newSectionsCount = newCollection.count % columnsCount == 0 ?
            newCollection.count / columnsCount :
            newCollection.count / columnsCount + 1

        let lastNewSectionIndex = firstNewSectionIndex + newSectionsCount

        if currentPage == 1 {
            collection = newCollection
            onReload?()
        } else {
            collection.append(contentsOf: newCollection)
            onSectionsInsertion?(.init(integersIn: firstNewSectionIndex ..< lastNewSectionIndex))
        }

        currentPage += 1
    }
}
