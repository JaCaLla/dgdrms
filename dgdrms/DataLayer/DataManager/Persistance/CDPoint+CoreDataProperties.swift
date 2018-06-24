//
//  CDPoint+CoreDataProperties.swift
//
//
//  Created by 08APO0516 on 17/01/2018.
//
//

import Foundation
import CoreData

extension CDPoint {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDPoint> {
        return NSFetchRequest<CDPoint>(entityName: "CDPoint")
    }

    @NSManaged public var address: String?
    @NSManaged public var desc: String?
    @NSManaged public var email: String?
    @NSManaged public var geocoordinates: String?
    @NSManaged public var id: String?
    @NSManaged public var phone: String?
    @NSManaged public var title: String?
    @NSManaged public var transport: String?

}
