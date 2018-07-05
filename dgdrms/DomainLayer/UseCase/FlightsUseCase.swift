//
//  UserUseCase.swift
//  tempos21test
//
//  Created by 08APO0516 on 18/01/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import Foundation

final class FlightUseCase {

    static let shared =  FlightUseCase()

    private init() {}
   
    static func getCurrencies(onComplete: @escaping ([Currency]) -> Void, onFailed: @escaping () -> Void ) {
        DataManager.shared.getCurrencies(onSuccess: onComplete, onFailed: onFailed)
    }
    
}
