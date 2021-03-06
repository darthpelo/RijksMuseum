//
//  CollectionDetailsRequest.swift
//  RijksMuseum
//
//  Created by Alessio Roberto on 12/05/22.
//

import Foundation

/// RijsData API image search request model
struct CollectionDetailsRequest: Request {
    struct Response: Decodable {
        let artObject: ArtObjectDetails
    }

    let query: String
}

struct ArtObjectDetails: Decodable {
    let objectNumber: String
    let principalOrFirstMaker: String
    let title: String
    let description: String
    let webImage: WebImage
}
