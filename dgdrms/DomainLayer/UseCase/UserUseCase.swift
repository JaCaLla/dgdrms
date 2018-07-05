//
//  UserUseCase.swift
//  tempos21test
//
//  Created by 08APO0516 on 18/01/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import Foundation

final class UserUseCase {

    static let shared =  UserUseCase()

    private init() {}
   
    static func getUserSettings(onComplete: @escaping (User?,[Currency]) -> Void, onFailed: @escaping () -> Void ) {
        var user:User?
        var currencies:[Currency]?
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()//dispatchGroup.leave()
        DataManager.shared.getUser { _user in
            user = _user
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        DataManager.shared.getCurrencies(onSuccess: { _currencies in
            currencies = _currencies
            dispatchGroup.leave()
        }) {
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            guard let _currencies = currencies else {
                onFailed()
                return
            }
            onComplete(user,_currencies)
        }
    }
    
    static func set(user:User,onComplete:( ) -> Void) {
        
        
        DataManager.shared.set(user: user, onComplete: onComplete)
    }
}
