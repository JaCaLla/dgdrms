//
//  CDReservation+CoreDataClass.swift
//  
//
//  Created by 08APO0516 on 26/06/2018.
//
//

import Foundation
import CoreData


public class CDReservation: NSManagedObject {

    func set(reservation:Reservation) {
        self.origin                     = reservation.origin
        self.destination                = reservation.destination
        self.departureDateOrigin        = reservation.departureDateOrigin
        self.departureTimeOrigin        = reservation.departureTimeOrigin
        self.departureDateDestination   = reservation.departureDateDestination
        self.departureTimeDestination   = reservation.departureTimeDestination
    }
    
    func get() -> Reservation {
        return Reservation(origin: self.origin!,
                    destination: self.destination!,
                    departureDateOrigin: self.departureDateOrigin!,
                    departureTimeOrigin: self.departureTimeOrigin!,
                    departureDateDestination: self.departureDateDestination!,
                    departureTimeDestination: self.departureTimeDestination!)
    }
    
}
