//
//  CDUser+CoreDataClass.swift
//  
//
//  Created by 08APO0516 on 26/06/2018.
//
//

import Foundation
import CoreData


public class CDUser: NSManagedObject {

    func set(user:User) {
        self.name = user.name
        self.surename = user.surename
        self.dateOfBirth = user.dateOfBirth as NSDate
        self.currency = user.currency
    }

    func get() -> User {
        return User(name: self.name!,
                    surename: self.surename!,
                    dateOfBirth: self.dateOfBirth! as Date,
                    currency: self.currency!)
    }
}
