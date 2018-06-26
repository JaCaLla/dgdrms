//
//  UTFlight.swift
//  dgdrmsTests
//
//  Created by 08APO0516 on 24/06/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import XCTest
@testable import dgdrms
class UTFlight: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_flight_constructor() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let exchangeRates:[String:Double] = ["USD":0.8]
        
        let inbound = Bound(airline: "a", airlineImage: "b", arrivalDate: "c", arrivalTime: "d", departureDate: "e", departureTime: "f", destination: "g", origin: "h")
        let outbound = Bound(airline: "1", airlineImage: "2", arrivalDate: "3", arrivalTime: "4", departureDate: "5", departureTime: "6", destination: "7", origin: "8")
        
        let flight =  Flight(inbound: inbound, outbound: outbound, price: 100, currency: "USD")
        
        guard let flightWithPriceConverted = Flight(flight: flight, userCurrency: "EUR", exchangeRates: exchangeRates) else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(flightWithPriceConverted.currency, "EUR")
        XCTAssertEqual(flightWithPriceConverted.price, 80)
        
    }

    
}
