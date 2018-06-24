//
//  CDExchangeRate+CoreDataClass.swift
//  
//
//  Created by 08APO0516 on 24/06/2018.
//
//

import Foundation
import CoreData

//@objc(CDExchangeRate)
public class CDExchangeRate: NSManagedObject {

    func set(exchangeRate:ExchangeRate) {
        
        self.from = exchangeRate.from
        self.to = exchangeRate.to
        self.rate = exchangeRate.rate
    }
    
    func get() -> ExchangeRate {
        return ExchangeRate(from: self.from!,
                            to: self.to!,
                            rate: self.rate)
    }
}
