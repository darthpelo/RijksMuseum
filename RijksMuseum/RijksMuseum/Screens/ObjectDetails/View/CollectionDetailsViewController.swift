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
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let placeholderView = PlaceholderView()
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

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        placeholderView.frame = .init(
            x: 0.0,
            y: 0.0,
            width: view.frame.width,
            height: view.safeAreaLayoutGuide.layoutFrame.maxY
        )

        placeholderView.bounds = placeholderView.frame
    }

    private func setupObservers() {
        viewModel.onReload = { details in
            details.bind(to: self.detailsView)
        }

        viewModel.$isActivityIndicatorAnimating.onValueChange = { [weak self] isAnimating in
            if isAnimating {
                self?.activityIndicator.startAnimating()
            } else {
                self?.activityIndicator.stopAnimating()
            }
        }

        viewModel.$isPlaceholderHidden.onValueChange = { [weak self] isHidden in
            self?.placeholderView.isHidden = isHidden
        }
    }

    private func setupSubviews() {
        view.backgroundColor = appearance.backgroundColor

        view.addSubview(placeholderView)
        placeholderView.setImage(appearance.placeholderViewImage)
        placeholderView.setTitle(viewModel.placeholderTitle)
        placeholderView.isHidden = viewModel.isPlaceholderHidden

        view.addSubview(detailsView)

        view.addSubview(activityIndicator)
        activityIndicator.backgroundColor = appearance.activityIndicatorBackgroundColor
        activityIndicator.layer.cornerRadius = appearance.activityIndicatorBackgroundCornerRadius
    }

    private func setupConstraints() {
        detailsView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(view)
        }

        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
    }
}

extension CollectionDetailsViewController {
    struct Appearance {
        let backgroundColor: UIColor = .systemGray
        let placeholderViewImage: UIImage = .init(named: "no_results_placeholder") ?? .init()
        let activityIndicatorBackgroundColor: UIColor = .clear
        let activityIndicatorBackgroundCornerRadius: CGFloat = 2.0
    }
}
