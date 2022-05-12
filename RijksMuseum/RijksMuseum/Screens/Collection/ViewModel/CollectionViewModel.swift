//
//  CollectionViewModel.swift
//  RijksMuseum
//
//  Created by Alessio Roberto on 12/05/22.
//

import UIKit

/// Collection screen business-logic
final class CollectionViewModel {
    /// Number of columns in each row
    let columnsCount: Int = 2

    /// Collection list placeholder title label text
    let placeholderTitle: String = "No results"

    /// Activity indicator animating state
    @Observable
    private(set) var isActivityIndicatorAnimating: Bool = false

    /// Collection list placeholder visibility indicator
    @Observable
    private(set) var isPlaceholderHidden: Bool = false

    private let service: CollectionRequesting
    private let router: CollectionRouting

    /// Designated initializer
    /// - Parameter service: Collection service
    /// - Parameter router: Router
    init(service: CollectionRequesting, router: CollectionRouting) {
        self.service = service
        self.router = router
    }
}
