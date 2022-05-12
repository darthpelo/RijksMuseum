//
//  CollectionViewController+CollectionView.swift
//  RijksMuseum
//
//  Created by Alessio Roberto on 12/05/22.
//

import UIKit

// MARK: - UICollectionViewDelegateFlowLayout

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _: UICollectionView,
        layout _: UICollectionViewLayout,
        sizeForItemAt _: IndexPath
    ) -> CGSize {
        .init(width: cellSize, height: cellSize * 1.5)
    }

    func collectionView(
        _: UICollectionView,
        layout _: UICollectionViewLayout,
        insetForSectionAt _: Int
    ) -> UIEdgeInsets {
        .zero
    }

    func collectionView(
        _: UICollectionView,
        layout _: UICollectionViewLayout,
        minimumLineSpacingForSectionAt _: Int
    ) -> CGFloat {
        .zero
    }

    func collectionView(
        _: UICollectionView,
        layout _: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt _: Int
    ) -> CGFloat {
        .zero
    }

    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.onCellSelection(atIndexPath: indexPath)
    }
}

// MARK: - UICollectionViewDataSource

extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell
        else {
            return .init()
        }

        let model = viewModel.collection[indexPath.section * viewModel.columnsCount + indexPath.row]
        model.bind(to: cell)

        return cell
    }

    func numberOfSections(in _: UICollectionView) -> Int {
        if viewModel.collection.count % viewModel.columnsCount == 0 {
            return fullRowsCount
        } else {
            return fullRowsCount + 1
        }
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section < fullRowsCount {
            return viewModel.columnsCount
        } else {
            return viewModel.collection.count % viewModel.columnsCount
        }
    }
}
