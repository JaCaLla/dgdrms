//
//  Flight.swift
//  dgdrms
//
//  Created by 08APO0516 on 16/01/2018.
//  Copyright © 2018 jca. All rights reserved.
//
import Foundation

struct  ExchangeRate {

    struct JSONKey {
        static let currency     = "currency"
        static let exchangeRate      = "exchangeRate"
    }

    var rate:Double    = -1.0
    var from        = ""
    var to         = ""

    init?(from:String, dictionary: JSONDictionary?) {

        guard let _exchangeRate = dictionary?[JSONKey.exchangeRate] as? Double,
            let _currency = dictionary?[JSONKey.currency] as? String else {
                return nil
        }
        self.init(from: from, to: _currency, rate: _exchangeRate)
    }

    init(from:String,to:String,rate:Double) {
        self.from = from
        self.to = to
        self.rate = rate
    }
}
