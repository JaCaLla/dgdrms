//
//  FetchExchangeRatesOperation.swift
//
//
//

import Foundation
import UIKit

class FetchExchangeRatesOperation: ConcurrentOperation {

    override init() {
        super.init()
    }

    override func main() {
        DataManager.shared.getUser(onComplete: { user in
            
            guard let _user = user else {
                DataManager.shared.getExchangeRates(to: "EUR", onComplete: {_ in
                    self.state = .Finished
                })
                return
            }
            
            DataManager.shared.getExchangeRates(to: _user.currency, onComplete: {_ in
                self.state = .Finished
            })
        })

    }
}
