//
//  UTVehiclesRestService.swift
//  dgdrmsTests
//
//  Created by 08APO0516 on 05/07/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import XCTest
@testable import dgdrms
class UTVehiclesRestService: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_getVehicles() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let asyncExpectation = expectation(description: "\(#function)")
        
        let boundingBox = BoundingBox(cornerUpLeft: Coordinate(latitude: 53.394655, longitude: 9.757589),
                                      cornerDownRight: Coordinate(latitude: 53.694865, longitude: 10.099891))
        
        
        VehiclesRestService.shared.getVehicles(boundingBox: boundingBox, onSuccess: { pois in
            guard pois.count == 111 else  { XCTFail(); asyncExpectation.fulfill(); return }
            
            
            asyncExpectation.fulfill()
        }) { _ in
            XCTFail()
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
}
