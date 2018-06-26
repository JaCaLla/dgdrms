//
//  UTRatesRestService.swift
//  dgdrmsTests
//
//  Created by 08APO0516 on 23/06/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import XCTest
@testable import dgdrms
class UTRatesRestService: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_getRate_EUR_USD() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let asyncExpectation = expectation(description: "\(#function)")

        RatesRestService.shared.rate(from: "EUR", to: "USD", onSuccess: { exchangeRate in
            XCTAssertEqual(exchangeRate.from, "EUR")
            XCTAssertEqual(exchangeRate.to, "USD")
            XCTAssert(exchangeRate.rate != -1)
            asyncExpectation.fulfill()
        }) { _ in
            XCTFail()
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
