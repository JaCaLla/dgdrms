//
//  User.swift
//  dgdrms
//
//  Created by 08APO0516 on 22/06/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import Foundation

struct Currency {

    var coin    = ""

    struct JSONKey {
        static let currency = "currency"
    }

    init(coin: String) {
        self.coin   = coin
    }

    // MARK: Public Methods
    static func getCurrenciesFrom(array: [JSONDictionary]?) -> [Currency] {
        guard let _array = array else { return [] }

        let currencies:[Currency] = _array.map {
            let jsonFlight = $0
            if let _coin = jsonFlight[JSONKey.currency] as? String {
                return Currency(coin: _coin)
            } else {
                return Currency(coin: "")
            }
            }.filter {
                $0.coin.isEmpty == false
            }.filterDuplicates {  $0.coin == $1.coin
            }.sorted { $0.coin.localizedCaseInsensitiveCompare($1.coin) == .orderedAscending }

        return currencies
    }

}

extension Currency: Equatable {
    static func == (lhs: Currency, rhs: Currency) -> Bool {
        return lhs.coin == rhs.coin
    }
}
