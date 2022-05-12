//
//  CollectionModel.swift
//  RijksMuseum
//
//  Created by Alessio Roberto on 12/05/22.
//

import UIKit

/// Collection presenter model
final class CollectionModel {
    private weak var presenter: CollectionPresentable?

    private let imageLoader: ImageLoading
    private let loadingTitle: String
    private let failureTitle: String
    private let imageTitle: String

    /// Designated initializer
    /// - Parameter imageLoader: Asynchronous image loading service
    /// - Parameter loadingTitle: Loading state cell title text
    /// - Parameter failureTitle: Failed state cell title text
    init(
        imageLoader: ImageLoading,
        imageTitle: String,
        loadingTitle: String,
        failureTitle: String
    ) {
        self.imageLoader = imageLoader
        self.imageTitle = imageTitle
        self.loadingTitle = loadingTitle
        self.failureTitle = failureTitle
    }
}
