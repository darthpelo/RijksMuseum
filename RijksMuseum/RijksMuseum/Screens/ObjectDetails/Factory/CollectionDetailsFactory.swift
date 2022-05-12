//
//  CollectionDetailsFactory.swift
//  RijksMuseum
//
//  Created by Alessio Roberto on 12/05/22.
//

import UIKit

/// Collection detail module creation factory
final class CollectionDetailsFactory {
    /// Creates collection detail module
    /// - Parameter navigationController: Navigation context
    /// - Parameter objectNumber: ArtObject number
    func create(withNavigationController _: UINavigationController,
                objectNumber: String) -> UIViewController
    {
        let service = CollectionDetailsService(requester: { UrlRestApiRequester(apiUrl: $0) })
        let viewModel = CollectionDetailsViewModel(service: service, objectNumber: objectNumber)

        return CollectionDetailsViewController(viewModel: viewModel)
    }
}
