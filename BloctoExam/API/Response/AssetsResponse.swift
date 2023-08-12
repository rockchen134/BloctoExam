//
//  AssetsResponse.swift
//  BloctoExam
//
//  Created by Rock Chen on 2023/8/11.
//

import Foundation

struct AssetsResponse: Decodable {
    let assets: [Asset]
}

struct Asset: Decodable {
    let name: String
    let image_url: URL?
    let description: String
    let permalink: URL
    let collection: Collection
}

struct Collection: Decodable {
    let name: String
}
