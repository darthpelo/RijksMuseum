//
//  CollectionDetailsPresentable.swift
//  RijksMuseum
//
//  Created by Alessio Roberto on 12/05/22.
//

import UIKit

/// Interface of the view presenting the collection details
/// sourcery: AutoMockable
protocol CollectionDetailsPresentable: AnyObject {
    /// Assings the tiltle label text
    /// - Parameter title: Title label text
    func setTitle(_ title: String)

    /// Assigns the search result image
    /// - Parameter image: Search result image
    func setImage(_ image: UIImage)
}
