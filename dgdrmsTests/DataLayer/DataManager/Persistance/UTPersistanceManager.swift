//
//  UTPersistanceManager.swift
//  dgdrmsTests
//
//  Created by 08APO0516 on 22/06/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import XCTest
@testable import dgdrms
class UTPersistanceManager: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        PersistanceManager.shared.reset()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_addUser() {
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        PersistanceManager.shared.getUser(onComplete: { user in
            XCTAssertNil(user)
            
            XCTAssertEqual(PersistanceManager.shared.isUserSet(),false)
            XCTAssertEqual(PersistanceManager.shared.getUserCount(), 0)
            let user = User(name: "1", surename: "2")
            PersistanceManager.shared.set(user: user) {
                XCTAssertEqual(PersistanceManager.shared.isUserSet(),true)
                XCTAssertEqual(PersistanceManager.shared.getUserCount(), 1)
                
                PersistanceManager.shared.getUser(onComplete: { user in
                    guard let _user = user else {
                        XCTFail()
                        asyncExpectation.fulfill()
                        return
                    }
                    XCTAssertEqual(_user.name, "1")
                    XCTAssertEqual(_user.surename, "2")
                    
                    let user = User(name: "a", surename: "b")
                    PersistanceManager.shared.set(user: user) {
                        XCTAssertEqual(PersistanceManager.shared.isUserSet(),true)
                        XCTAssertEqual(PersistanceManager.shared.getUserCount(), 1)
                        
                        PersistanceManager.shared.getUser(onComplete: { user in
                            guard let _user = user else {
                                XCTFail()
                                asyncExpectation.fulfill()
                                return
                            }
                            XCTAssertEqual(_user.name, "a")
                            XCTAssertEqual(_user.surename, "b")
                            asyncExpectation.fulfill()
                        })
                    }
                    
                })
            }
        })
        
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_getCurrencies() {
        let asyncExpectation = expectation(description: "\(#function)")
        
        XCTAssertEqual(PersistanceManager.shared.getCurrencyCount(),0)
        PersistanceManager.shared.getCurrencies { currencies in
            XCTAssertEqual(currencies, [])
            let currencies = [Currency(coin: "EUR"),Currency(coin: "GBP"),Currency(coin: "JPY"),Currency(coin: "USD")]
            PersistanceManager.shared.set(currencies: currencies, onComplete: {
                XCTAssertEqual(PersistanceManager.shared.getCurrencyCount(),4)
                PersistanceManager.shared.getCurrencies { currencies in
                    XCTAssertEqual(currencies, [Currency(coin: "EUR"),Currency(coin: "GBP"),Currency(coin: "JPY"),Currency(coin: "USD")])
                    let currencies = [Currency(coin: "PTA")]
                    PersistanceManager.shared.set(currencies: currencies, onComplete: {
                        XCTAssertEqual(PersistanceManager.shared.getCurrencyCount(),1)
                        PersistanceManager.shared.getCurrencies { currencies in
                            XCTAssertEqual(currencies, [Currency(coin: "PTA")])
    
                            PersistanceManager.shared.resetCurrencies()
                            XCTAssertEqual(PersistanceManager.shared.getCurrencyCount(),0)
                            asyncExpectation.fulfill()
                        }
                    })
                }
            })
        }
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    
    func test_exchangeRates() {
        let asyncExpectation = expectation(description: "\(#function)")
        
        PersistanceManager.shared.get(from: "EUR", to: "USD", onComplete: { exchangeRate in
            XCTAssertNil(exchangeRate)
            let exchangeRate = ExchangeRate(from: "EUR", to: "USD", rate: 2)
            PersistanceManager.shared.set(exchangeRate: exchangeRate) {
                PersistanceManager.shared.get(from: "USD", to: "EUR", onComplete: { exchangeRate in
                    XCTAssertNil(exchangeRate)
                    PersistanceManager.shared.get(from: "EUR", to: "USD", onComplete: { exchangeRate in
                        guard let _exchangeRate = exchangeRate else {
                            XCTFail()
                            asyncExpectation.fulfill()
                            return
                        }
                        XCTAssertEqual(_exchangeRate.from, "EUR")
                        XCTAssertEqual(_exchangeRate.to, "USD")
                        XCTAssertEqual(_exchangeRate.rate, 2.0)
                        asyncExpectation.fulfill()
                    })
                    
                })
            }
        })
        
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
