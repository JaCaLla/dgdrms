//
//  Flight.swift
//  dgdrms
//
//  Created by 08APO0516 on 16/01/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import Foundation

struct  Flight {

    var price:Double    = -1.0
    var currency        = ""
    var inbound         = Bound(airline: "", airlineImage: "", arrivalDate: "", arrivalTime: "", departureDate: "", departureTime: "", destination: "", origin: "")
    var outbound        = Bound(airline: "", airlineImage: "", arrivalDate: "", arrivalTime: "", departureDate: "", departureTime: "", destination: "", origin: "")

    struct JSONKey {
        static let price        = "price"
        static let currency     = "currency"
        static let inbound      = "inbound"
        static let outbound     = "outbound"
    }
    
    init(inbound:Bound,outbound:Bound,price:Double,currency:String) {
        
        self.inbound = inbound
        self.outbound = outbound
        self.price  = price
        self.currency = currency
    }
    

    init?(flight:Flight,userCurrency:String,exchangeRates:[String:Double]) {
        guard let _rate = exchangeRates[flight.currency] else { return nil }
        
        self.init(inbound: flight.inbound, outbound: flight.outbound, price: flight.price * _rate, currency: userCurrency)
    }
    
    // MARK: Public Methods
    static func getFlightsFrom(array: [JSONDictionary]?) -> [Flight]? {

        guard let _flights = array else { return nil }

        return decode(_flights)
    }
    
    func getOrigin() -> String {
        return self.inbound.origin
    }
    
    func getDestionation() -> String {
        return self.inbound.destination
    }
}
extension Flight: JSONDecodable {
    // MARK: JSONDecodable
    init?(dictionary: JSONDictionary?) {

        guard let _price = dictionary?[JSONKey.price] as? Double,
            let _currency = dictionary?[JSONKey.currency] as? String,
            let _jsonInbound = dictionary?[JSONKey.inbound] as? JSONDictionary,
            let _jsonOutbound = dictionary?[JSONKey.outbound] as? JSONDictionary,
            let _inbound = Bound(dictionary: _jsonInbound),
            let _outbound = Bound(dictionary: _jsonOutbound) else {
                return nil
        }

        self.price = _price
        self.currency = _currency
        self.inbound = _inbound
        self.outbound = _outbound
    }

}
