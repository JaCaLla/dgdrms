//
//  Destinations.swift
//  dgdrms
//
//  Created by 08APO0516 on 24/06/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import Foundation

class Origin:NSObject {
    
    var origin = ""
    var flights:[Flight] = []
    
    init(origin:String) {
        self.origin = origin
    }
    
     func add(flight:Flight) {
        
        let newElement = flight
        let index = self.flights.insertionIndexOf(elem: newElement) { $0.price < $1.price }
        self.flights.insert(newElement, at: index)
    }
}
