//
//  Flight.swift
//  dgdrms
//
//  Created by 08APO0516 on 16/01/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import Foundation

struct Bound {

    var airline         = ""
    var airlineImage    = ""
    var arrivalDate     = ""
    var arrivalTime     = ""
    var departureDate   = ""
    var departureTime   = ""
    var destination     = ""
    var origin          = ""

    struct JSONKey {
        static let airline          = "airline"
        static let airlineImage     = "airlineImage"
        static let arrivalDate      = "arrivalDate"
        static let arrivalTime      = "arrivalTime"
        static let departureDate    = "departureDate"
        static let departureTime    = "departureTime"
        static let destination      = "destination"
        static let origin           = "origin"
    }
    
    init(airline:String,
         airlineImage:String,
         arrivalDate:String,
         arrivalTime:String,
         departureDate:String,
         departureTime:String,
         destination:String,
         origin:String) {
        
        self.airline = airline
        self.airlineImage = airlineImage
        self.arrivalDate  = arrivalDate
        self.arrivalTime = arrivalTime
        self.departureDate = departureDate
        self.departureTime = departureTime
        self.destination = destination
        self.origin = origin
    }

}

// MARK: JSONDecodable
extension Bound: JSONDecodable {

    init?(dictionary: JSONDictionary?) {

        guard let _airline = dictionary?[JSONKey.airline] as? String,
            let _airlineImage = dictionary?[JSONKey.airlineImage] as? String,
            let _arrivalDate = dictionary?[JSONKey.arrivalDate] as? String,
            let _arrivalTime = dictionary?[JSONKey.arrivalTime] as? String,
            let _departureDate = dictionary?[JSONKey.departureDate] as? String,
            let _departureTime = dictionary?[JSONKey.departureTime] as? String,
            let _destination = dictionary?[JSONKey.destination] as? String,
            let _origin = dictionary?[JSONKey.origin] as? String else {
                return nil
        }

        self.airline = _airline
        self.airlineImage = _airlineImage
        self.arrivalDate = _arrivalDate
        self.arrivalTime = _arrivalTime
        self.departureDate = _departureDate
        self.departureTime = _departureTime
        self.destination    = _destination
        self.origin         = _origin
    }

}
