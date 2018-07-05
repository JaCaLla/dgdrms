//
//  DomainManager.swift
//  dgdrms
//
//  Created by 08APO0516 on 27/06/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import Foundation

class  DomainManager {
    
    static let shared =  DomainManager()
    
    private init() {
        //This prevents others from using the default '()' initializer for this class.
    }
    
    // MARK: - Reset
    func reset() {

    }
}
