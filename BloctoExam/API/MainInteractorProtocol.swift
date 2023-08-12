//
//  MainInteractorProtocol.swift
//  BloctoExam
//
//  Created by Rock Chen on 2023/8/11.
//

import Foundation
import Alamofire

protocol MainInteractorProtocol {
    @discardableResult
    func getAssets(parameters: AssetsRequest, success: @escaping ((AssetsResponse) -> Void), failure: @escaping ((Error) -> Void)) -> DataRequest?
}
