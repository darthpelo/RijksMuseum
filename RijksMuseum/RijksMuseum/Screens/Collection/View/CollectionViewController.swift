//
//  CollectionViewController.swift
//  RijksMuseum
//
//  Created by Alessio Roberto on 12/05/22.
//

import SnapKit
import UIKit

/// Displays the Collection results screen
final class CollectionViewController: UIViewController {
    internal typealias Cell = CollectionCell

    private let appearance = Appearance()
    internal let viewModel: CollectionViewModel

    private let refreshControl = UIRefreshControl()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let placeholderView = CollectionPlaceholderView()
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    internal var fullRowsCount: Int { viewModel.collection.count / viewModel.columnsCount }
    internal var cellSize: CGFloat { view.bounds.width / CGFloat(viewModel.columnsCount) }
    internal let refreshGapInRows: Int = 2

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

    @objc
    private func onRefreshControlDrag() {
        viewModel.onPullToRefresh()
    }

    private func setupObservers() {
        viewModel.onPullToRefreshDeactivation = { [weak self] in
            if let self = self, self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
        }

        viewModel.$isActivityIndicatorAnimating.onValueChange = { [weak self] isAnimating in
            if isAnimating {
                self?.activityIndicator.startAnimating()
                self?.view.isUserInteractionEnabled = false
            } else {
                self?.activityIndicator.stopAnimating()
                self?.view.isUserInteractionEnabled = true
            }
        }

        viewModel.onReload = { [weak self] in
            self?.collectionView.reloadData()
        }

        viewModel.onSectionsInsertion = { [weak self] sectionsIndices in
            self?.collectionView.insertSections(sectionsIndices)
        }

        viewModel.$isPlaceholderHidden.onValueChange = { [weak self] isHidden in
            self?.placeholderView.isHidden = isHidden
        }
    }

    private func setupSubviews() {
        navigationController?.isNavigationBarHidden = appearance.isNavigationBarHidden
        navigationItem.backButtonTitle = appearance.backbuttonTitle
        title = appearance.navigationTitle
        view.backgroundColor = appearance.backgroundColor

        view.addSubview(collectionView)
        collectionView.alwaysBounceVertical = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = appearance.collectionViewShowsVerticalScrollIndicator
        collectionView.register(Cell.self, forCellWithReuseIdentifier: Cell.reuseIdentifier)

        collectionView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(onRefreshControlDrag), for: .valueChanged)

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

// MARK: - UIScrollViewDelegate {

extension CollectionViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height

        let refreshGap = CGFloat(refreshGapInRows) * cellSize

        if maximumOffset - currentOffset <= refreshGap, currentOffset > 0, maximumOffset > 0 {
            viewModel.onBottomDragging()
        }
    }
}
