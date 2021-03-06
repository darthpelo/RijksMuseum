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
    let placeholderTitle: String = "Somenthing went wrong.\nTry later"

    /// Pull-to-refresh indicator deactivation event handler
    var onPullToRefreshDeactivation: (() -> Void)?

    /// Full screen reload event handler
    var onReload: (() -> Void)?

    /// New sections insertion event handler
    var onSectionsInsertion: ((IndexSet) -> Void)?

    /// Activity indicator animating state
    @Observable
    private(set) var isActivityIndicatorAnimating = false

    /// Collection list placeholder visibility indicator
    @Observable
    private(set) var isPlaceholderHidden: Bool = true

    /// Collection model
    private(set) var collection: [CollectionModel] = [] {
        didSet {
            isPlaceholderHidden = !collection.isEmpty
        }
    }

    private var currentPage: Int = 1
    private var pageSize: Int = 10

    private let imagePool = ImagePool.shared

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
        // Observe internet connection
        [Notifications.Reachability.connected.name,
         Notifications.Reachability.notConnected.name].forEach { notification in
            NotificationCenter.default.addObserver(self, selector: #selector(changeInternetConnection), name: notification, object: nil)
        }

        isActivityIndicatorAnimating = true
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

    /// Handles cell selection event
    /// - Parameter atIndexPath: Index of the touched cell
    func onCellSelection(atIndexPath indexPath: IndexPath) {
        let model = collection[indexPath.section * columnsCount + indexPath.row]
        router.showDetails(objectNumber: model.objectNumber)
    }

    // MARK: - Private

    @objc
    private func changeInternetConnection(notification: Notification) {
        if notification.name == Notifications.Reachability.notConnected.name {
            error()
        }
    }

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

    private func getImages() -> Result<[ArtObjectData], Error>? {
        var result: Result<[ArtObjectData], Error>?

        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()

        service.getImages(ofMaxResults: pageSize, forPage: currentPage) { res in
            result = res
            dispatchGroup.leave()
        }

        dispatchGroup.wait()

        return result
    }

    private func handleImages(_ result: Result<[ArtObjectData], Error>) {
        DispatchQueue.main.async { [weak self] in
            if case let .success(data) = result {
                self?.appendNewImages(data)
            } else if self?.currentPage == 1 {
                self?.error()
            }
        }
    }

    private func appendNewImages(_ data: [ArtObjectData]) {
        isActivityIndicatorAnimating = false
        onPullToRefreshDeactivation?()

        let newCollection: [CollectionModel] = data.compactMap {
            let path = $0.url.replacingOccurrences(of: "=s0", with: "=w200")
            guard let url = URL(string: path) else { return nil }

            let imageLoader = ImageLoader(queue: imageLoadingQueue, url: url, cache: imagePool)
            let model = CollectionModel(
                objectNumber: $0.objectNumber,
                imageLoader: imageLoader,
                imageTitle: $0.title
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

    private func error() {
        DispatchQueue.main.async { [weak self] in
            self?.isActivityIndicatorAnimating = false
            self?.isPlaceholderHidden = false
            self?.collection = []
            self?.onReload?()
        }
    }
}
