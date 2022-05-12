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
        maxResults _: Int,
        forPage _: Int,
        _: @escaping (Result<[(title: String, url: String)], Error>) -> Void
    ) {}
}
