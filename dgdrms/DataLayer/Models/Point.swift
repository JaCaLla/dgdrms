//
//  Point.swift
//  tempos21test
//
//  Created by 08APO0516 on 16/01/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import Foundation

struct Point {

    var identifier      = ""
    var title           = ""
    var address         = ""
    var transport       = ""
    var email           = ""
    var geocoordinates  = ""
    var description     = ""
    var phone           = ""

    struct JSONKey {
        static let identifier       = "id"
        static let title            = "title"
        static let address          = "address"
        static let transport        = "transport"
        static let email            = "email"
        static let geocoordinates   = "geocoordinates"
        static let description      = "description"
        static let phone            = "phone"
    }

    init(identifier: String,
         title: String,
         geocoordinates: String) {

        self.identifier         = identifier
        self.title              = title
        self.geocoordinates     = geocoordinates
    }

    init(identifier: String,
         title: String,
         address: String,
         transport: String,
         email: String,
         geocoordinates: String,
         description:String,
         phone:String) {

        self.init(identifier: identifier, title: title, geocoordinates: geocoordinates)

        self.address            = address
        self.transport          = transport
        self.email              = email
        self.description        = description
        self.phone              = phone
    }

    init?(jsonDictionary:JSONDictionary ) {

        guard let _identifier = jsonDictionary[JSONKey.identifier] as? String,
            let _title = jsonDictionary[JSONKey.title] as? String,
            let _geocoordinates = jsonDictionary[JSONKey.geocoordinates] as? String else {
                return nil
        }

        let _address        = jsonDictionary[JSONKey.address] as? String ?? ""
        let _transport      = jsonDictionary[JSONKey.transport] as? String ?? ""
        let _email          = jsonDictionary[JSONKey.email] as? String ?? ""
        let _description    = jsonDictionary[JSONKey.description] as? String ?? ""
        let _phone          = jsonDictionary[JSONKey.phone] as? String ?? ""

        self.init(identifier: _identifier,
                  title: _title,
                  address:_address,
                  transport: _transport,
                  email: _email,
                  geocoordinates: _geocoordinates,
                  description: _description,
                  phone:_phone)
    }

    func hasDetail() -> Bool {
        return !self.identifier.isEmpty &&
            !self.title.isEmpty &&
            !self.address.isEmpty &&
            !self.transport.isEmpty &&
            !self.email.isEmpty &&
            !self.geocoordinates.isEmpty &&
            !self.description.isEmpty &&
            !self.phone.isEmpty
    }
}
