//
//  CDUser+CoreDataClass.swift
//  
//
//  Created by 08APO0516 on 22/06/2018.
//
//

import Foundation
import CoreData

//@objc(CDUser)
public class CDUser: NSManagedObject {
    
    func set(user:User) {
        self.name = user.name
        self.surename = user.surename
    }
    
    func get() -> User {
        return User(name: self.name!,
                     surename: self.surename!)
    }
}
