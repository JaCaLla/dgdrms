//
//  Flight.swift
//  dgdrms
//
//  Created by 08APO0516 on 16/01/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import Foundation

struct BoundingBox {

    var cornerUpLeft:Coordinate     = Coordinate(latitude: 0.0, longitude: 0.0)
    var cornerDownRight:Coordinate  = Coordinate(latitude: 0.0, longitude: 0.0)
   
    struct JSONKey {
        static let latitude      = "latitude"
        static let longitude     = "longitude"
    }
    
    init(cornerUpLeft:Coordinate,
         cornerDownRight:Coordinate) {
        
        self.cornerUpLeft = cornerUpLeft
        self.cornerDownRight = cornerDownRight
    }

    // MARK: Public/Helpers
    func queryItems() -> [URLQueryItem] {
        
        struct RestParam  {
            static let p1Lat = "p1Lat"
            static let p1Lon = "p1Lon"
            static let p2Lat = "p2Lat"
            static let p2Lon = "p2Lon"
        }
        
        return [URLQueryItem(name: RestParam.p1Lat, value: String(self.cornerUpLeft.latitude)),
                URLQueryItem(name: RestParam.p1Lon, value: String(self.cornerUpLeft.longitude)),
                URLQueryItem(name: RestParam.p2Lat, value: String(self.cornerDownRight.latitude)),
                URLQueryItem(name: RestParam.p2Lon, value: String(self.cornerDownRight.longitude))]
    }
}
