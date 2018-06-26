//
//  Destinations.swift
//  dgdrms
//
//  Created by 08APO0516 on 24/06/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import Foundation

class Destinations:NSObject {
    
    var destinations:[Destination] = []
    
    
     func add(flightWithUserCurrency:Flight) {
        
        let destinationName = flightWithUserCurrency.getDestionation()
        var destination = Destination(destination: destinationName)
        if let _desination =  destinations.first(where: {$0.destination == destinationName }) {
            destination = _desination
        }
        
        let originName = flightWithUserCurrency.getOrigin()
        var origin = Origin(origin: originName)
        if let _origin = destination.origins.first(where: {$0.origin == originName }) {
            origin = _origin
        }
    
        origin.add(flight:flightWithUserCurrency)
        destination.addIfNecessary(origin: origin)
        self.addIfNecessary(destination:destination)
        
    }
    
    
    // MARK: - Private/Internal
    private  func addIfNecessary(destination:Destination) {
        
        if var _destination = self.destinations.first(where: {$0.destination == destination.destination }) {
            _destination = destination
        } else {
            let newElement = destination
            let index = self.destinations.insertionIndexOf(elem: newElement) { $0.destination < $1.destination }
            self.destinations.insert(newElement, at: index)
            
            //self.destinations.append(destination)
        }
    }
}
