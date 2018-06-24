//
//  DataManager.swift
//  eshop30
//
//  Copyright © 2017 08APO0516ja. All rights reserved.
//

import Foundation

class  DataManager {

    static let shared =  DataManager()

    private init() {
        //This prevents others from using the default '()' initializer for this class.
    }
    
    // MARK: - Private attributes
    var currenciesCached:[Currency] = []
    var exchageRateCached:[String:ExchangeRate] = [:]
    
    // MARK: - Reset
    func reset() {

        FlightsRestService.shared.reset()
        PersistanceManager.shared.reset()
    }
    
    // MARK: - Flights
    func getFlights(onSuccess: @escaping ([Flight]) -> Void, onFailed: @escaping ( ) -> Void ) {
        
        FlightsRestService.shared.getFlights(onSuccess: onSuccess) { _ in
            onFailed()
        }
    }
    
    // MARK: - Currencies
    func getCurrencies(onSuccess: @escaping ([Currency]) -> Void, onFailed: @escaping ( ) -> Void ) {
        guard currenciesCached.isEmpty else { onSuccess(self.currenciesCached); return }
        
        guard PersistanceManager.shared.getCurrencyCount() == 0 else {
            PersistanceManager.shared.getCurrencies { [weak self] currencies in
                guard let weakSelf = self else { return }
                weakSelf.currenciesCached = currencies
                onSuccess(weakSelf.currenciesCached)
                return
            }
            return
        }
       
        FlightsRestService.shared.getCurrencies(onSuccess: { [weak self] currencies in
            guard let weakSelf = self else { return }
            weakSelf.currenciesCached = currencies
            PersistanceManager.shared.set(currencies: currencies, onComplete: { })
            onSuccess(weakSelf.currenciesCached)
        }) { _ in
            onFailed()
        }
    }
    
    
    // MARK: - Exchange rate
    func getExchageRate(from:String, to:String, onSuccess:  @escaping (ExchangeRate) -> Void, onFail: @escaping () -> Void ) {
        if let _exchangeRate = exchageRateCached[to] {
            onSuccess(_exchangeRate)
            return
        }
        
        PersistanceManager.shared.get(from: from, to: to) { exchangeRate in
            guard let _exchangeRate = exchangeRate else {
                RatesRestService.shared.rate(from: from, to: to, onSuccess: { exchangeRate in
                    PersistanceManager.shared.set(exchangeRate: exchangeRate, onComplete: {
                        self.exchageRateCached[to] = exchangeRate
                        onSuccess(exchangeRate)
                    })
                }, onFailed: { _ in
                    onFail()
                })
                return
            }
            self.exchageRateCached[to] = _exchangeRate
            onSuccess(_exchangeRate)
        }
        
    }
    
    /*
     func getPoints(onComplete: @escaping ([Point]) -> Void) {

     guard PersistanceManager.shared.isEmpty() else {
     PersistanceManager.shared.getPoints(onComplete: onComplete)
     return
     }

     FlightsRestService.shared.getPoints(onSuccess: { points in
     PersistanceManager.shared.add(points: points, onComplete: {
     onComplete(points)
     })
     }) { _ in
     onComplete([])
     }
     }

     func getDetailedPoint(point:Point, onComplete: @escaping (Point?) -> Void ) {

     PersistanceManager.shared.getDetail(point: point) { pointWithDetail in
     if let _pointWithDetail = pointWithDetail {
     onComplete(_pointWithDetail)
     return
     } else {
     FlightsRestService.shared.getPoint(identifier: point.identifier, onSuccess: { pointFromService in
     PersistanceManager.shared.update(source: point,
     destination: pointFromService,
     onComplete: { result in
     onComplete( result ? pointFromService : nil)
     })
     }, onFailed: { _ in
     onComplete(nil)
     })
     }
     }
     }
     */
}
