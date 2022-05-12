//
//  CollectionViewController+Apparence.swift
//  RijksMuseum
//
//  Created by Alessio Roberto on 12/05/22.
//

import UIKit

internal extension CollectionViewController {
    struct Appearance {
        let isNavigationBarHidden = false
        let backgroundColor: UIColor = .systemBackground
        let searchBarStyle: UISearchBar.Style = .minimal
        let searchBarTextFieldClearButtonMode: UITextField.ViewMode = .never
        let collectionViewShowsVerticalScrollIndicator = false
        let placeholderViewImage: UIImage = .init(named: "no_results_placeholder") ?? .init()
        let activityIndicatorBackgroundColor: UIColor = .clear
        let activityIndicatorBackgroundCornerRadius: CGFloat = 2.0
        let navigationTitle = "RijksMuseum Painting"
    }
}
