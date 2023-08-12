//
//  MainInteractor.swift
//  BloctoExam
//
//  Created by Rock Chen on 2023/8/11.
//

import Foundation
import Alamofire

class MainInteractor: MainInteractorProtocol {
    private let url = "https://testnets-api.opensea.io/api/v1/assets"
    
    @discardableResult
    func getAssets(parameters: AssetsRequest, success: @escaping ((AssetsResponse) -> Void), failure: @escaping ((Error) -> Void)) -> DataRequest? {
        return AF.request(url, method: .get, parameters: parameters).validate().responseDecodable(of: AssetsResponse.self) { responseData in
            switch responseData.result {
            case .success(let response):
                success(response)
            case .failure(let error):
                failure(error)
            }
        }
    }
}
