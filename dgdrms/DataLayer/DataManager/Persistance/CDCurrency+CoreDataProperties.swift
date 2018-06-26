//
//  CDCurrency+CoreDataProperties.swift
//
//
//  Created by 08APO0516 on 23/06/2018.
//
//

import Foundation
import CoreData

extension CDCurrency {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDCurrency> {
        return NSFetchRequest<CDCurrency>(entityName: "CDCurrency")
    }

    @NSManaged public var coin: String?

}
