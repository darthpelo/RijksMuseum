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

    let objectNumber: String
    private let imageLoader: ImageLoading
    private let imageTitle: String

    /// Designated initializer
    /// - Parameter objectNumber: Collection object number
    /// - Parameter imageLoader: Asynchronous image loading service
    init(
        objectNumber: String,
        imageLoader: ImageLoading,
        imageTitle: String
    ) {
        self.objectNumber = objectNumber
        self.imageLoader = imageLoader
        self.imageTitle = imageTitle
    }

    /// Binds model to presenter
    /// - Parameter presenter: Presenter to be binded to
    func bind(to presenter: CollectionPresentable) {
        unbind()

        self.presenter = presenter

        presenter.setPlaceholder()
        presenter.setOnPrepareForReuse { [weak self] in
            self?.unbind()
        }

        imageLoader.loadImage { [weak self] image in
            self?.onImageLoadSuccess(image)
        } onFailure: { [weak self] in
            self?.onImageLoadFailure()
        }
    }

    /// Unbinds model from presenter
    func unbind() {
        presenter = nil
        imageLoader.cancelLoading()
    }

    private func onImageLoadSuccess(_ image: UIImage) {
        DispatchQueue.main.async {
            self.presenter?.setImage(image)
            self.presenter?.setTitle(self.imageTitle)
        }
    }

    private func onImageLoadFailure() {
        DispatchQueue.main.async {
            self.presenter?.setTitle("")
        }
    }
}
