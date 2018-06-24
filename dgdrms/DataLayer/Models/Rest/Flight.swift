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
    var inbound         = Bound()
    var outbound        = Bound()
    
    struct JSONKey {
        static let price        = "price"
        static let currency     = "currency"
        static let inbound      = "inbound"
        static let outbound     = "outbound"
    }
    
    // MARK: Public Methods
    static func getFlightsFrom(array: [JSONDictionary]?) -> [Flight]? {
        
        guard let _flights = array else { return nil }
        
        return decode(_flights)
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

