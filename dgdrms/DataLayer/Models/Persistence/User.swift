//
//  User.swift
//  dgdrms
//
//  Created by 08APO0516 on 22/06/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import Foundation

struct User {

    var name             = ""
    var surename         = ""
    var dateOfBirth:Date = Date()
    var currency         = ""
/*
    struct JSONKey {
        static let name             = "name"
        static let surename         = "surename"
    }
*/
    init(name: String,
         surename: String,
         dateOfBirth:Date,
         currency:String) {

        self.name           = name
        self.surename       = surename
        self.dateOfBirth    = dateOfBirth
        self.currency       = currency
    }

}
