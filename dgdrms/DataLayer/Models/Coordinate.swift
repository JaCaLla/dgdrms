//
//  Flight.swift
//  dgdrms
//
//  Created by 08APO0516 on 16/01/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import Foundation

struct Coordinate {

    var latitude:Double     = 0.0
    var longitude:Double    = 0.0
   
    struct JSONKey {
        static let latitude      = "latitude"
        static let longitude     = "longitude"
    }
    
    init(latitude:Double,
         longitude:Double) {
        
        self.latitude = latitude
        self.longitude = longitude
    }

}

// MARK: JSONDecodable
extension Coordinate: JSONDecodable {

    init?(dictionary: JSONDictionary?) {

        guard let _latitude = dictionary?[JSONKey.latitude] as? Double,
            let _longitude = dictionary?[JSONKey.longitude] as? Double else {
                return nil
        }

        self.latitude = _latitude
        self.longitude = _longitude
    }
}
