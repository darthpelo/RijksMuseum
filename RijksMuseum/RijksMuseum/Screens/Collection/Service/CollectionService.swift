//
//  CollectionService.swift
//  RijksMuseum
//
//  Created by Alessio Roberto on 11/05/22.
//

import Foundation

final class CollectionService: CollectionRequesting {
    private let apiUrl = "https://www.rijksmuseum.nl/api/en/collection"
    private let apikey = "0fiuZFh4"
    private let requester: Requesting

    /// Designated initializer
    /// - Parameter requester: Lazy requester initializer
    init(requester: (String) -> (Requesting)) {
        self.requester = requester(apiUrl)
    }

    func getImages(
        ofMaxResults maxResults: Int,
        forPage page: Int,
        _ completion: @escaping (Result<[(title: String, url: String)], Error>) -> Void
    ) {
        let request = CollectionRequest(query: "?key=\(apikey)&imgonly=true&type=painting&p=\(page)&ps=\(maxResults)")
        requester.make(request: request) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case let .success(response):
                let imageData = response.artObjects.map { (self.imageTitle(fromPhoto: $0), self.imageUrl(fromPhoto: $0)) }
                completion(.success(imageData))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    private func imageUrl(fromPhoto photo: CollectionRequest.Response.ArtObject) -> String {
        photo.webImage.url
    }

    private func imageTitle(fromPhoto photo: CollectionRequest.Response.ArtObject) -> String {
        photo.title
    }
}
