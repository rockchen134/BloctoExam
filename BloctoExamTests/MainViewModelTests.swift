//
//  MainViewModelTests.swift
//  BloctoExamTests
//
//  Created by Rock Chen on 2023/8/12.
//

import Alamofire
import XCTest

final class ViewModelTests: XCTestCase {

    func test_init() {
        let sut: MainViewModel? = makeSUT()
        XCTAssertNotNil(sut)
    }
    
    func test_should_get_data() {
        let sut: MainViewModel? = makeSUT()
        sut?.fetch()
        let exp = expectation(description: "Wait")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            XCTAssertNotNil(sut!.item(index: 0))
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_deallocated() {
        var sut: MainViewModel? = makeSUT()
        weak var weakSut = sut
        sut = nil
        XCTAssertNil(weakSut, "Instance should have been deallocated")
    }
    
    private func makeSUT() -> MainViewModel? {
        let sut = MainViewModel(interactor: MainInteractorSpy())
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
