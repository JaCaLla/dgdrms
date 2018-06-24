//
//  CDPoint+CoreDataClass.swift
//
//
//  Created by 08APO0516 on 17/01/2018.
//
//

import Foundation
import CoreData

public class CDPoint: NSManagedObject {

    func set(point:Point) {
        self.id = point.identifier
        self.title = point.title
        self.address = point.address
        self.transport = point.transport
        self.email = point.email
        self.geocoordinates = point.geocoordinates
        self.desc = point.description
        self.phone = point.phone
    }

    func get() -> Point {
        return Point(identifier: self.id!,
                     title: self.title!,
                     address: self.address!,
                     transport: self.transport!,
                     email: self.email!,
                     geocoordinates: self.geocoordinates!,
                     description: self.desc!,
                     phone: self.phone!)
    }

}
