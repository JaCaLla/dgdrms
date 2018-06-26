//
//  UTFlightRestService.swift
//  dgdrmsTests
//
//  Created by 08APO0516 on 22/06/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import XCTest
@testable import dgdrms
class UTFlightRestService: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_getFlights() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let asyncExpectation = expectation(description: "\(#function)")
        
        FlightsRestService.shared.getFlights(onSuccess: { flights in
            guard flights.count == 1000 else  { XCTFail(); asyncExpectation.fulfill(); return }
            
            asyncExpectation.fulfill()
        }) { _ in
            XCTFail()
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func test_getCurrencies() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let asyncExpectation = expectation(description: "\(#function)")
        
        FlightsRestService.shared.getCurrencies(onSuccess: { currencies in
            XCTAssertEqual(currencies, [Currency(coin: "EUR"),Currency(coin: "GBP"),Currency(coin: "JPY"),Currency(coin: "USD")])
            
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
