//
//  CollectionViewController.swift
//  RijksMuseum
//
//  Created by Alessio Roberto on 12/05/22.
//

import UIKit

/// Displays the search results screen
final class CollectionViewController: UIViewController {
    private let viewModel: CollectionViewModel

    /// Designated initializer
    /// - Parameter viewModel: ViewModel
    init(viewModel: CollectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
