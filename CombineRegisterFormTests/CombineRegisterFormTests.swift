//
//  CombineRegisterFormTests.swift
//  CombineRegisterFormTests
//
//  Created by Masoud Sheikh Hosseini on 10/15/22.
//

import XCTest
import Combine


final class CombineRegisterFormTests: XCTestCase {
    
    var subscriptions = [AnyCancellable]()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_validatesPasswordLength() {
        let expectation = XCTestExpectation(description: "waiting...")

        let sut = FormModel()
        sut.password = "12345678"
        sut.repeatPassword = sut.password
        
        sut.$validationError
            .sink(receiveValue: { value in
                XCTAssertNil(value)
                expectation.fulfill()
            })
            .store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_validatesPasswordsMatch() {
        let expectation = XCTestExpectation(description: "waiting...")

        let sut = FormModel()
        sut.password = "12345678"
        sut.repeatPassword = "12345678"
        
        sut.$validationError
            .sink(receiveValue: { value in
                XCTAssertNil(value)
                expectation.fulfill()
            })
            .store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 1)

    }
}
