//
//  CollectionService.swift
//  RijksMuseum
//
//  Created by Alessio Roberto on 11/05/22.
//

import Foundation

typealias ArtObjectData = (title: String, url: String, objectNumber: String)

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
        _ completion: @escaping (Result<[ArtObjectData], Error>) -> Void
    ) {
        let request = CollectionRequest(query: "?key=\(apikey)&imgonly=true&type=painting&p=\(page)&ps=\(maxResults)")
        requester.make(request: request) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case let .success(response):
                let imageData = response.artObjects.map { self.imageData(fromArtObject: $0) }
                completion(.success(imageData))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    private func imageData(fromArtObject artObject: ArtObject) -> ArtObjectData {
        (artObject.title, artObject.webImage.url, artObject.objectNumber)
    }
}
