//
//  CollectionDetailsService.swift
//  RijksMuseum
//
//  Created by Alessio Roberto on 12/05/22.
//

import Foundation

final class CollectionDetailsService: CollectionDetailsRequesting {
    private let apiUrl: String = "https://www.rijksmuseum.nl/api/en/collection"
    private let requester: Requesting

    /// Designated initializer
    /// - Parameter requester: Lazy requester initializer
    init(requester: (String) -> (Requesting)) {
        self.requester = requester(apiUrl)
    }

    func getImage(ofObjectNumber _: String,
                  _: @escaping (Result<(title: String, url: String), Error>) -> Void) {}
}
