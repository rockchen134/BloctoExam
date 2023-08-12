//
//  DetailViewModelTests.swift
//  BloctoExamTests
//
//  Created by Rock Chen on 2023/8/12.
//

import XCTest
import Alamofire

final class DetailViewModelTests: XCTestCase {

    func test_init() {
        let sut: DetailViewModel? = makeSUT()
        XCTAssertNotNil(sut)
    }
    
    func test_should_get_data() {
        let sut: DetailViewModel? = makeSUT()
        XCTAssertNotNil(sut?.asset)
    }
    
    func test_deallocated() {
        var sut: DetailViewModel? = makeSUT()
        weak var weakSut = sut
        sut = nil
        XCTAssertNil(weakSut, "Instance should have been deallocated")
    }
    
    private func makeSUT() -> DetailViewModel? {
        var sut: DetailViewModel? = nil
        let data = JsonFileHelper.loadMockJSONData(with: "AssetsResponse")
        if let response = try? JSONDecoder().decode(AssetsResponse.self, from: data) {
            let asset = response.assets[0]
            sut = DetailViewModel(asset: asset)
        }
        return sut
    }
        
    private final class MainInteractorSpy: MainInteractor {
        override func getAssets(parameters: AssetsRequest, success: @escaping ((AssetsResponse) -> Void), failure: @escaping ((Error) -> Void)) -> DataRequest? {
            let data = JsonFileHelper.loadMockJSONData(with: "AssetsResponse")
            let response = try? JSONDecoder().decode(AssetsResponse.self, from: data)
            
            XCTAssertNotNil(response)
            
            if let response = response {
                success(response)
            }
            
            return nil
        }
    }

}
