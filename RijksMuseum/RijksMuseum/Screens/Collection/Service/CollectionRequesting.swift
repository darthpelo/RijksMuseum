//
//  CollectionRequesting.swift
//  RijksMuseum
//
//  Created by Alessio Roberto on 11/05/22.
//

import Foundation

/// Search results service interface
/// sourcery: AutoMockable
protocol CollectionRequesting: AnyObject {
    /// Requests bunch of images
    /// - Parameter ofMaxResults: The number of results per page
    /// - Parameter forPage: Page index
    /// - Parameter completion: Request completion handler. Returns the images Tiles, URLs list
    func getImages(
        ofMaxResults maxCount: Int,
        forPage page: Int,
        _ completion: @escaping (Result<[ArtObjectData], Error>) -> Void
    )
}
