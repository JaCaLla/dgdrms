//
//  User.swift
//  dgdrms
//
//  Created by 08APO0516 on 22/06/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import Foundation

struct Reservation {

    var origin                      = ""
    var destination                 = ""
    var departureDateOrigin         = ""
    var departureTimeOrigin         = ""
    var departureDateDestination    = ""
    var departureTimeDestination    = ""

    init(origin: String,
         destination: String,
         departureDateOrigin:String,
         departureTimeOrigin:String,
         departureDateDestination:String,
         departureTimeDestination:String) {

        self.origin                     = origin
        self.destination                = destination
        self.departureDateOrigin        = departureDateOrigin
        self.departureTimeOrigin        = departureTimeOrigin
        self.departureDateDestination   = departureDateDestination
        self.departureTimeDestination   = departureTimeDestination
    }

}
