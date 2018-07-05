//
//  CDReservation+CoreDataProperties.swift
//  
//
//  Created by 08APO0516 on 26/06/2018.
//
//

import Foundation
import CoreData


extension CDReservation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDReservation> {
        return NSFetchRequest<CDReservation>(entityName: "CDReservation")
    }

    @NSManaged public var departureDateDestination: String?
    @NSManaged public var departureDateOrigin: String?
    @NSManaged public var departureTimeDestination: String?
    @NSManaged public var departureTimeOrigin: String?
    @NSManaged public var destination: String?
    @NSManaged public var origin: String?

}
