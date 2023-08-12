//
//  MainInteractorTests.swift
//  BloctoExamTests
//
//  Created by Rock Chen on 2023/8/12.
//

import XCTest
import Alamofire

final class MainInteractorTests: XCTestCase {

    func test_init() {
        let sut: MainInteractorSpy? = makeSUT()
        XCTAssertNotNil(sut)
    }
    
    func test_get_apiCallCountHasBeenIncreasedAfterPerformAssestAPI() {
        let sut = makeSUT()
        let parameters = AssetsRequest(owner: "", offset: 0, limit: 1)
        sut?.getAssets(parameters: parameters, success: { _ in
        }, failure: { _ in })
        XCTAssertEqual(sut?.callCount, 1)
    }
    
    func test_deallocated() {
        var sut: MainInteractorSpy? = makeSUT()
        weak var weakSut = sut
        sut = nil
        XCTAssertNil(weakSut, "Instance should have been deallocated")
    }
    
    private func makeSUT() -> MainInteractorSpy? {
        let sut = MainInteractorSpy()
        return sut
    }
        
    private final class MainInteractorSpy: MainInteractor {
        private(set) var callCount: Int = 0
        
        @discardableResult
        override func getAssets(parameters: AssetsRequest, success: @escaping ((AssetsResponse) -> Void), failure: @escaping ((Error) -> Void)) -> DataRequest? {
            callCount+=1
            return nil
            
        }
    }
}
