//
//  CDUser+CoreDataProperties.swift
//  
//
//  Created by 08APO0516 on 26/06/2018.
//
//

import Foundation
import CoreData


extension CDUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDUser> {
        return NSFetchRequest<CDUser>(entityName: "CDUser")
    }

    @NSManaged public var name: String?
    @NSManaged public var surename: String?
    @NSManaged public var dateOfBirth: NSDate?
    @NSManaged public var currency: String?

}
