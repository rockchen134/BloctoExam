//
//  AssetsRequest.swift
//  BloctoExam
//
//  Created by Rock Chen on 2023/8/11.
//

import Foundation

struct AssetsRequest: Encodable {
    let owner: String
    let offset: Int
    let limit: Int
}
