//
//  CollectionDetailsRequesting.swift
//  RijksMuseum
//
//  Created by Alessio Roberto on 12/05/22.
//

import Foundation

/// Search results service interface
/// sourcery: AutoMockable
protocol CollectionDetailsRequesting: AnyObject {
    /// Requests bunch of images
    /// - Parameter objectNumber: The identifier of the object (case-sensitive).
    /// - Parameter completion: Request completion handler. Returns the images Tiles, URLs list
    func getImage(
        ofObjectNumber objectNumber: String,
        _ completion: @escaping (Result<(title: String, url: String), Error>) -> Void
    )
}
