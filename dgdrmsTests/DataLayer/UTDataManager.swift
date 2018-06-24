//
//  UTDataManager.swift
//  dgdrmsTests
//
//  Created by 08APO0516 on 23/06/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import XCTest

@testable import dgdrms
class UTDataManager: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        DataManager.shared.reset()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    // MARK: - Flights
    func test_getFlights() {
        let asyncExpectation = expectation(description: "\(#function)")
        
        DataManager.shared.getFlights(onSuccess: { flights in
            guard flights.count == 1000 else  { XCTFail(); asyncExpectation.fulfill(); return }
            
            asyncExpectation.fulfill()
        }) {
            XCTFail()
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
    }

    // MARK: - Currencies
    func test_getCurrencies() {
        let asyncExpectation = expectation(description: "\(#function)")
        
        XCTAssertEqual(DataManager.shared.currenciesCached, [])
        PersistanceManager.shared.getCurrencies(onComplete: { currencies in
            XCTAssertEqual(currencies, [])
            DataManager.shared.getCurrencies(onSuccess: { currencies in
                XCTAssertEqual(currencies, [Currency(coin: "EUR"),Currency(coin: "GBP"),Currency(coin: "JPY"),Currency(coin: "USD")])
                XCTAssertEqual(DataManager.shared.currenciesCached, [Currency(coin: "EUR"),Currency(coin: "GBP"),Currency(coin: "JPY"),Currency(coin: "USD")])
                PersistanceManager.shared.getCurrencies(onComplete: { currencies in
                    XCTAssertEqual(currencies, [Currency(coin: "EUR"),Currency(coin: "GBP"),Currency(coin: "JPY"),Currency(coin: "USD")])
                    
                    DataManager.shared.currenciesCached = []
                    
                    DataManager.shared.getCurrencies(onSuccess: { currencies in
                        XCTAssertEqual(currencies, [Currency(coin: "EUR"),Currency(coin: "GBP"),Currency(coin: "JPY"),Currency(coin: "USD")])
                        XCTAssertEqual(DataManager.shared.currenciesCached, [Currency(coin: "EUR"),Currency(coin: "GBP"),Currency(coin: "JPY"),Currency(coin: "USD")])
                        asyncExpectation.fulfill()
                        
                    }) {
                        XCTFail()
                        asyncExpectation.fulfill()
                    }
                })
                
            }) {
                XCTFail()
                asyncExpectation.fulfill()
            }
        })
        self.waitForExpectations(timeout: 10, handler: nil)
    }

    // MARK: - Exchage rates
    func test_getExchangeRates() {
        let asyncExpectation = expectation(description: "\(#function)")
        
        XCTAssertEqual(DataManager.shared.exchageRateCached.keys.count, 0)
        PersistanceManager.shared.get(from: "EUR", to: "USD") { exchangeRate in
            XCTAssertNil(exchangeRate)
            DataManager.shared.getExchageRate(from: "EUR", to: "USD", onSuccess: { exchangeRate in
                XCTAssertEqual(exchangeRate.from, "EUR")
                XCTAssertEqual(exchangeRate.to, "USD")
                XCTAssertEqual(exchangeRate.rate != -1, true)
                
                DataManager.shared.exchageRateCached = [:]
                
                DataManager.shared.getExchageRate(from: "EUR", to: "USD", onSuccess: { exchangeRate in
                    XCTAssertEqual(exchangeRate.from, "EUR")
                    XCTAssertEqual(exchangeRate.to, "USD")
                    XCTAssertEqual(exchangeRate.rate != -1, true)
                    
                    XCTAssertEqual(DataManager.shared.exchageRateCached["USD"]?.from, "EUR")
                    XCTAssertEqual(DataManager.shared.exchageRateCached["USD"]?.to, "USD")
                    XCTAssertEqual(DataManager.shared.exchageRateCached["USD"]?.rate != -1, true)
                    
                    asyncExpectation.fulfill()
                    
                }, onFail: {
                    XCTFail()
                    asyncExpectation.fulfill()
                })
                
            }, onFail: {
                XCTFail()
                asyncExpectation.fulfill()
            })

        }
        
        
        /*
        PersistanceManager.shared.getCurrencies(onComplete: { currencies in
            XCTAssertEqual(currencies, [])
            DataManager.shared.getCurrencies(onSuccess: { currencies in
                XCTAssertEqual(currencies, [Currency(coin: "EUR"),Currency(coin: "GBP"),Currency(coin: "JPY"),Currency(coin: "USD")])
                XCTAssertEqual(DataManager.shared.currenciesCached, [Currency(coin: "EUR"),Currency(coin: "GBP"),Currency(coin: "JPY"),Currency(coin: "USD")])
                PersistanceManager.shared.getCurrencies(onComplete: { currencies in
                    XCTAssertEqual(currencies, [Currency(coin: "EUR"),Currency(coin: "GBP"),Currency(coin: "JPY"),Currency(coin: "USD")])
                    
                    DataManager.shared.currenciesCached = []
                    
                    DataManager.shared.getCurrencies(onSuccess: { currencies in
                        XCTAssertEqual(currencies, [Currency(coin: "EUR"),Currency(coin: "GBP"),Currency(coin: "JPY"),Currency(coin: "USD")])
                        XCTAssertEqual(DataManager.shared.currenciesCached, [Currency(coin: "EUR"),Currency(coin: "GBP"),Currency(coin: "JPY"),Currency(coin: "USD")])
                        asyncExpectation.fulfill()
                        
                    }) {
                        XCTFail()
                        asyncExpectation.fulfill()
                    }
                })
                
            }) {
                XCTFail()
                asyncExpectation.fulfill()
            }
        })*/
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    // MARK: - Users
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
