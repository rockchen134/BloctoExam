//
//  AppCoordinatorTests.swift
//  BloctoExamTests
//
//  Created by Rock Chen on 2023/8/12.
//

import XCTest

final class AppCoordinatorTests: XCTestCase {

    func test_init() {
        let sut: AppCoordinator? = makeSUT()
        XCTAssertNotNil(sut)
    }
    
    func test_deallocated() {
        var sut: AppCoordinator? = makeSUT()
        sut?.start()
        weak var weakSut = sut
        sut = nil
        XCTAssertNil(weakSut, "Instance should have been deallocated")
    }
    
    func makeSUT() -> AppCoordinator? {
        let navigationController = UINavigationController()
        let sut: AppCoordinator? = AppCoordinator(navigationController: navigationController)
        return sut
    }

}
