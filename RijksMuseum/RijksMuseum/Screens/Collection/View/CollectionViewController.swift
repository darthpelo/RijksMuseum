//
//  CollectionViewController.swift
//  RijksMuseum
//
//  Created by Alessio Roberto on 12/05/22.
//

import SnapKit
import UIKit

/// Displays the search results screen
final class CollectionViewController: UIViewController {
    private let appearance = Appearance()
    private let viewModel: CollectionViewModel

    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let placeholderView = CollectionPlaceholderView()
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

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

    override func viewDidLoad() {
        super.viewDidLoad()

        setupObservers()
        setupSubviews()
        setupConstraints()

        viewModel.onViewLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if !placeholderView.isHidden {
            placeholderView.frame = .init(
                x: 0.0,
                y: 0.0,
                width: collectionView.frame.width,
                height: view.safeAreaLayoutGuide.layoutFrame.maxY
            )

            placeholderView.bounds = placeholderView.frame
        }
    }

    private func setupObservers() {}
    private func setupSubviews() {
        navigationController?.isNavigationBarHidden = appearance.isNavigationBarHidden
        view.backgroundColor = appearance.backgroundColor

        view.addSubview(collectionView)
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = appearance.collectionViewShowsVerticalScrollIndicator

        collectionView.addSubview(placeholderView)
        placeholderView.setImage(appearance.placeholderViewImage)
        placeholderView.setTitle(viewModel.placeholderTitle)
        placeholderView.isHidden = viewModel.isPlaceholderHidden

        view.addSubview(activityIndicator)
        activityIndicator.backgroundColor = appearance.activityIndicatorBackgroundColor
        activityIndicator.layer.cornerRadius = appearance.activityIndicatorBackgroundCornerRadius
    }

    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(view)
        }
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
    }
}

// MARK: - Appearance

private extension CollectionViewController {
    struct Appearance {
        let isNavigationBarHidden: Bool = true
        let backgroundColor: UIColor = .systemBackground
        let searchBarStyle: UISearchBar.Style = .minimal
        let searchBarTextFieldClearButtonMode: UITextField.ViewMode = .never
        let collectionViewShowsVerticalScrollIndicator: Bool = false
        let placeholderViewImage: UIImage = .init(named: "no_results_placeholder") ?? .init()
        let activityIndicatorBackgroundColor: UIColor = .white
        let activityIndicatorBackgroundCornerRadius: CGFloat = 2.0
    }
}
