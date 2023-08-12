//
//  DetailCoordinatorTests.swift
//  BloctoExamTests
//
//  Created by Rock Chen on 2023/8/12.
//

import XCTest

final class DetailCoordinatorTests: XCTestCase {

    func test_init() {
        let sut: DetailCoordinator? = makeSUT()
        XCTAssertNotNil(sut)
    }
    
    func test_deallocated() {
        var sut: DetailCoordinator? = makeSUT()
        sut?.start()
        weak var weakSut = sut
        sut = nil
        XCTAssertNil(weakSut, "Instance should have been deallocated")
    }
    
    func makeSUT() -> DetailCoordinator? {
        let viewController = UIViewController()
        let _ = UINavigationController(rootViewController: viewController)
        let sut: DetailCoordinator? = DetailCoordinator(parentViewController: viewController)
        return sut
    }

}
