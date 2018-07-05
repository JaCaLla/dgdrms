//
//  PointsUseCase.swift
//  tempos21test
//
//  Created by 08APO0516 on 18/01/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import Foundation

class VehicleUseCase {

    static let shared =  VehicleUseCase()

    private init() {}
    
    func getVehicles(boundingBox:BoundingBox,
                     onSuccess: @escaping ([Poi]) -> Void,
                     onFailed: @escaping ( ) -> Void ) {
        
        DataManager.shared.getVehicles(boundingBox: boundingBox, onSuccess: onSuccess) { 
            onFailed()
        }
    }
    
}
