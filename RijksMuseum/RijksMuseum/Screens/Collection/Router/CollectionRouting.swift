//
//  CollectionRouting.swift
//  RijksMuseum
//
//  Created by Alessio Roberto on 12/05/22.
//

import Foundation

/// Collection module navigation manager interface
/// sourcery: AutoMockable
protocol CollectionRouting: AnyObject {
    /// Opens Collection module
    /// - Parameter onCompletion: Collection query input event completion handler
    func showCollection(_ onCompletion: @escaping (String) -> Void)
}
