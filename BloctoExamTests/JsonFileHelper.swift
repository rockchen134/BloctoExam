//
//  JsonFileHelper.swift
//  BloctoExamTests
//
//  Created by Rock Chen on 2023/8/12.
//

import Foundation

final class JsonFileHelper {
    static func loadMockJSONData(with fileName: String) -> Data {
        let bundle = Bundle(for: JsonFileHelper.self)
        let path = bundle.path(forResource: fileName, ofType: "json")!
        let jsonData = try! Data(contentsOf: URL(fileURLWithPath: path))
        return jsonData
    }
}
