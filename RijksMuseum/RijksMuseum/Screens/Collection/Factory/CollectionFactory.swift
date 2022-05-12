//
//  CollectionFactory.swift
//  RijksMuseum
//
//  Created by Alessio Roberto on 12/05/22.
//

import UIKit

/// Search results module creation factory
final class CollectionFactory {
    /// Creates collection module
    /// - Parameter navigationController: Navigation context
    func create(withNavigationController navigationController: UINavigationController) -> UIViewController {
        let router = CollectionRouter(rootViewController: navigationController)
        let service = CollectionService(requester: { UrlRestApiRequester(apiUrl: $0) })
        let viewModel = CollectionViewModel(service: service, router: router)

        return CollectionViewController(viewModel: viewModel)
    }
}
