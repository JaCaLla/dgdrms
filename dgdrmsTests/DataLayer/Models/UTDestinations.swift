//
//  UTDestinations.swift
//  dgdrmsTests
//
//  Created by 08APO0516 on 24/06/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import XCTest
@testable import dgdrms
class UTDestinations: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_addOneFlight() {
        let inbound = Bound(airline: "a", airlineImage: "b", arrivalDate: "c", arrivalTime: "d", departureDate: "e", departureTime: "f", destination: "BCN", origin: "SVL")
        let outbound = Bound(airline: "1", airlineImage: "2", arrivalDate: "3", arrivalTime: "4", departureDate: "5", departureTime: "6", destination: "SVL", origin: "BCN")
        
        let flight =  Flight(inbound: inbound, outbound: outbound, price: 100, currency: "USD")
        
        var destinations = Destinations()
        destinations.add(flightWithUserCurrency: flight)
        
        XCTAssertEqual(destinations.destinations.count, 1)
        XCTAssertEqual(destinations.destinations[0].destination, "BCN")
        
        XCTAssertEqual(destinations.destinations[0].origins.count, 1)
        XCTAssertEqual(destinations.destinations[0].origins[0].origin, "SVL")
        
        
    }
    
    func test_addTwoFlightsSameDestintion() {

        let flight1 =  Flight(inbound:  Bound(airline: "a", airlineImage: "b", arrivalDate: "c", arrivalTime: "d", departureDate: "e", departureTime: "f", destination: "BCN", origin: "SVL"),
                              outbound: Bound(airline: "1", airlineImage: "2", arrivalDate: "3", arrivalTime: "4", departureDate: "5", departureTime: "6", destination: "SVL", origin: "BCN"),
                              price: 100, currency: "USD")

        let flight2 =  Flight(inbound: Bound(airline: "a", airlineImage: "b", arrivalDate: "c", arrivalTime: "d", departureDate: "e", departureTime: "f", destination: "BCN", origin: "MDR"),
                              outbound: Bound(airline: "1", airlineImage: "2", arrivalDate: "3", arrivalTime: "4", departureDate: "5", departureTime: "6", destination: "MDR", origin: "BCN"),
                              price: 100, currency: "USD")
        
        var destinations = Destinations()
        destinations.add(flightWithUserCurrency: flight1)
        destinations.add(flightWithUserCurrency: flight2)
        
        XCTAssertEqual(destinations.destinations.count, 1)
        XCTAssertEqual(destinations.destinations[0].destination, "BCN")
        
        XCTAssertEqual(destinations.destinations[0].origins.count, 2)
        XCTAssertEqual(destinations.destinations[0].origins[0].origin, "MDR")
        XCTAssertEqual(destinations.destinations[0].origins[1].origin, "SVL")
        
    }
    
    func test_addTwoFlightsDifferentDestintion() {
        
        let flight1 =  Flight(inbound:  Bound(airline: "a", airlineImage: "b", arrivalDate: "c", arrivalTime: "d", departureDate: "e", departureTime: "f", destination: "ROM", origin: "SVL"),
                              outbound: Bound(airline: "1", airlineImage: "2", arrivalDate: "3", arrivalTime: "4", departureDate: "5", departureTime: "6", destination: "SVL", origin: "ROM"),
                              price: 100, currency: "USD")
        
        let flight2 =  Flight(inbound: Bound(airline: "a", airlineImage: "b", arrivalDate: "c", arrivalTime: "d", departureDate: "e", departureTime: "f", destination: "PAR", origin: "MDR"),
                              outbound: Bound(airline: "1", airlineImage: "2", arrivalDate: "3", arrivalTime: "4", departureDate: "5", departureTime: "6", destination: "MDR", origin: "PAR"),
                              price: 100, currency: "USD")
        
        let destinations = Destinations()
        destinations.add(flightWithUserCurrency: flight1)
        destinations.add(flightWithUserCurrency: flight2)
        
        XCTAssertEqual(destinations.destinations.count, 2)
        XCTAssertEqual(destinations.destinations[0].destination, "PAR")
        XCTAssertEqual(destinations.destinations[1].destination, "ROM")
        
        XCTAssertEqual(destinations.destinations[0].origins.count, 1)
        XCTAssertEqual(destinations.destinations[0].origins[0].origin, "MDR")

        XCTAssertEqual(destinations.destinations[1].origins.count, 1)
        XCTAssertEqual(destinations.destinations[1].origins[0].origin, "SVL")
    }
    
}
