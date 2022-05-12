//
//  CollectionDetailsService.swift
//  RijksMuseum
//
//  Created by Alessio Roberto on 12/05/22.
//

import Foundation

final class CollectionDetailsService: CollectionDetailsRequesting {
    private let apiUrl: String = "https://www.rijksmuseum.nl/api/en/collection"
    private let apikey = "0fiuZFh4"
    private let requester: Requesting

    /// Designated initializer
    /// - Parameter requester: Lazy requester initializer
    init(requester: (String) -> (Requesting)) {
        self.requester = requester(apiUrl)
    }

    func getImage(ofObjectNumber objectNumber: String,
                  _ completion: @escaping (Result<(title: String, url: String), Error>) -> Void)
    {
        let request = CollectionDetailsRequest(query: "\(objectNumber)?key=\(apikey)")
        requester.make(request: request) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case let .success(response):
                let imageData = (title: self.imageTitle(fromPhoto: response.artObject),
                                 url: self.imageUrl(fromPhoto: response.artObject))
                completion(.success(imageData))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    private func imageUrl(fromPhoto photo: CollectionDetailsRequest.Response.ArtObject) -> String {
        photo.webImage.url
    }

    private func imageTitle(fromPhoto photo: CollectionDetailsRequest.Response.ArtObject) -> String {
        photo.title
    }
}
