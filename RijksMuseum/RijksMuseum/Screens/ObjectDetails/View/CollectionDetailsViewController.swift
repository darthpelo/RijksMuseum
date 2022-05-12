//
//  CollectionDetailsViewController.swift
//  RijksMuseum
//
//  Created by Alessio Roberto on 12/05/22.
//

import SnapKit
import UIKit

/// Displays the Collection results screen
final class CollectionDetailsViewController: UIViewController {
    private let viewModel: CollectionDetailsViewModel
    private let appearance = Appearance()

    private let detailsView = CollectionDetailsView()

    /// Designated initializer
    /// - Parameter viewModel: ViewModel
    init(viewModel: CollectionDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupObservers()
        setupSubviews()
        setupConstraints()

        viewModel.onViewLoad()
    }

    private func setupObservers() {
        viewModel.onReload = { details in
            details.bind(to: self.detailsView)
        }
    }

    private func setupSubviews() {
        view.backgroundColor = appearance.backgroundColor
        view.addSubview(detailsView)
    }

    private func setupConstraints() {
        detailsView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(view)
        }
    }
}

extension CollectionDetailsViewController {
    struct Appearance {
        let backgroundColor: UIColor = .systemBackground
        let placeholderViewImage: UIImage = .init(named: "no_results_placeholder") ?? .init()
        let activityIndicatorBackgroundColor: UIColor = .clear
        let activityIndicatorBackgroundCornerRadius: CGFloat = 2.0
    }
}
