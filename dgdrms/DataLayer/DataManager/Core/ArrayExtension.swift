//
//  ArrayExtension.swift
//  dgdrms
//
//  Created by 08APO0516 on 23/06/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import Foundation

extension Array {
    
    func filterDuplicates( includeElement: @escaping (_ lhs:Element, _ rhs:Element) -> Bool) -> [Element]{
        var results = [Element]()
        
        forEach { (element) in
            let existingElements = results.filter {
                return includeElement(element, $0)
            }
            if existingElements.isEmpty {
                results.append(element)
            }
        }
        
        return results
    }
}
