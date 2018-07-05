//
//  Poi.swift
//  dgdrms
//
//  Created by 08APO0516 on 16/01/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import Foundation

struct Poi {
    
    var ident: Int = -1
    var coordinate: Coordinate = Coordinate(latitude: 0.0, longitude: 0.0)
    var state:String = ""
    var type:String = ""
    var heading:Double = 0.0
    
    struct JSONKey {
        static let ident        = "id"
        static let coordinate    = "coordinate"
        static let state        = "state"
        static let type         = "type"
        static let heading      = "heading"
    }
    
    init(ident:Int,
         coordinate:Coordinate,
         state:String,
         type:String,
         heading:Double) {
        
        self.ident      = ident
        self.coordinate = coordinate
        self.state      = state
        self.type       = type
        self.heading    = heading
    }
    
    // MARK: Public Methods
    static func getPoiFrom(array: [JSONDictionary]?) -> [Poi]? {
        
        guard let _pois = array else { return nil }
        
        return decode(_pois)
    }
}

// MARK: JSONDecodable
extension Poi: JSONDecodable {
    
    init?(dictionary: JSONDictionary?) {
        
        guard let _ident = dictionary?[JSONKey.ident] as? Int,
            let _coordinateJson = dictionary?[JSONKey.coordinate] as? JSONDictionary,
            let _coordinate = Coordinate(dictionary: _coordinateJson),
            let _state = dictionary?[JSONKey.state] as? String,
            let _type = dictionary?[JSONKey.type] as? String,
            let _heading = dictionary?[JSONKey.heading] as? Double
        else {
            return nil
        }
        
        self.init(ident: _ident, coordinate: _coordinate, state: _state, type: _type, heading: _heading)
    }
}
