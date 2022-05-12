//
//  CollectionRouter.swift
//  RijksMuseum
//
//  Created by Alessio Roberto on 12/05/22.
//

import UIKit

/// Collection module navigation manager
final class CollectionRouter: CollectionRouting {
    private weak var rootViewController: UINavigationController?

    /// Designated initializer
    /// - Parameter rootViewController: Navigation context
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }

    func showCollection(_: @escaping (String) -> Void) {
        guard let rootViewController = rootViewController else { return }

        let factory = CollectionFactory()
        let viewController = factory.create(withNavigationController: rootViewController)
        rootViewController.pushViewController(viewController, animated: false)
    }
}
