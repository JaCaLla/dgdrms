//
//  Destinations.swift
//  dgdrms
//
//  Created by 08APO0516 on 24/06/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import Foundation

class Destination:NSObject {
    
    var destination = ""
    var origins:[Origin] = []
    
    init(destination:String) {
        self.destination = destination
    }
    
     func addIfNecessary(origin:Origin) {
        
        if  self.origins.first(where: {$0.origin == origin.origin })  == nil {
            
            let newElement = origin
            let index = self.origins.insertionIndexOf(elem: newElement) { $0.origin < $1.origin }
            self.origins.insert(newElement, at: index)
            
           // self.origins.append(origin)
        }
    }
}
