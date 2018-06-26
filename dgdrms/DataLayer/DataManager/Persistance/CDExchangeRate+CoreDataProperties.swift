//
//  CDExchangeRate+CoreDataProperties.swift
//
//
//  Created by 08APO0516 on 24/06/2018.
//
//

import Foundation
import CoreData

extension CDExchangeRate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDExchangeRate> {
        return NSFetchRequest<CDExchangeRate>(entityName: "CDExchangeRate")
    }

    @NSManaged public var from: String?
    @NSManaged public var rate: Double
    @NSManaged public var to: String?

}
