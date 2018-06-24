//
//  CDCurrency+CoreDataClass.swift
//  
//
//  Created by 08APO0516 on 23/06/2018.
//
//

import Foundation
import CoreData

//@objc(CDCurrency)
public class CDCurrency: NSManagedObject {

    func set(currency:Currency) {
        self.coin = currency.coin
    }
    
    func get() -> Currency {
        return Currency(coin: self.coin!)
    }
}
