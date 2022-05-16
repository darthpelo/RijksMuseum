//
//  CollectionRequest.swift
//  RijksMuseum
//
//  Created by Alessio Roberto on 11/05/22.
//

/// RijsData API image search request model
struct CollectionRequest: Request {
    struct Response: Decodable {
//        struct WebImage: Decodable {
//            let url: String
//        }
//
//        struct ArtObject: Decodable {
//            let objectNumber: String
//            let title: String
//            let webImage: WebImage
//        }

        let artObjects: [ArtObject]
    }

    let query: String
}

struct WebImage: Decodable {
    let url: String
}

struct ArtObject: Decodable {
    let objectNumber: String
    let title: String
    let webImage: WebImage
}
