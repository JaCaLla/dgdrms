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
    var exchangeRatesCached:[String:Double] = [:]

    // MARK: - Reset
    func reset() {

        self.currenciesCached = []
        self.exchageRateCached = [:]
        self.exchangeRatesCached = [:]

        FlightsRestService.shared.reset()
        PersistanceManager.shared.reset()
    }

    // MARK: - User
    func set(user:User, onComplete: () -> Void ) {
        
        PersistanceManager.shared.set(user: user, onComplete: onComplete)
    }
    
    func getUser(onComplete: (User?) -> Void) {
        
        PersistanceManager.shared.getUser(onComplete:onComplete)
    }
    
    func isUserSet() -> Bool {
        
        return PersistanceManager.shared.isUserSet()
    }
    
    // MARK: - Vehicles
    func getVehicles(boundingBox:BoundingBox,
                     onSuccess: @escaping ([Poi]) -> Void,
                     onFailed: @escaping ( ) -> Void ) {
        VehiclesRestService.shared.getVehicles(boundingBox: boundingBox, onSuccess: onSuccess) { _ in
            onFailed()
        }
    }
    
    // MARK: - Flights
    func getFlights(onSuccess: @escaping ([Flight]) -> Void, onFailed: @escaping ( ) -> Void ) {

        FlightsRestService.shared.getFlights(onSuccess: onSuccess) { _ in
            onFailed()
        }
    }
    
    // MARK: - Destinations
    func getDestinations(userCurrency:String, onSuccess: @escaping (Destinations) -> Void, onFailed: @escaping ( ) -> Void ) {
        
        DataManager.shared.getExchangeRates(to: userCurrency) { [weak self] exchangeRates in
            guard let weakSelf = self else  { return }
            weakSelf.getFlights(onSuccess: { flights in
                let flightsWithUserCurrency:[Flight] = flights.map {
                    let _flight = $0
                    return Flight(flight: _flight, userCurrency: userCurrency, exchangeRates: exchangeRates) ?? Flight(inbound: Bound(airline: "", airlineImage: "", arrivalDate: "", arrivalTime: "", departureDate: "", departureTime: "", destination: "", origin: ""), outbound:  Bound(airline: "", airlineImage: "", arrivalDate: "", arrivalTime: "", departureDate: "", departureTime: "", destination: "", origin: ""), price: -1, currency: "")
                    }.filter {
                        $0.price != -1
                }
                
                let destinations = Destinations()
                flightsWithUserCurrency.forEach({ flightWithUserCurrency in
                    destinations.add(flightWithUserCurrency: flightWithUserCurrency)
                })
                onSuccess(destinations)
                
                
            }, onFailed: {
                onFailed()
            })
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
    func getExchangeRates(to:String, onComplete: @escaping ([String:Double]) -> Void) {
        guard exchangeRatesCached.keys.isEmpty == true else {
            onComplete(exchangeRatesCached)
            return
        }

        self.getCurrencies(onSuccess: { [weak self] currencies in
            guard let weakSelf = self else { onComplete([:]); return}
            weakSelf.buildExchangeRates(to: to, currencies: currencies, onComplete: onComplete)
        }) {
            onComplete([:])
        }
    }

    func buildExchangeRates(to:String, currencies:[Currency], onComplete: @escaping ([String:Double]) -> Void) {
        guard let _firstCurrency = currencies.first  else { onComplete([:]); return }

        let _pendingCurrencies = Array(currencies[1..<currencies.count])

        self.buildExchangeRates(to:to, currencies: _pendingCurrencies) { exchangeRates in
            self.getExchageRate(from: _firstCurrency.coin, to: to, onSuccess: { exchangeRate in
                let exchangeRateMutable = NSMutableDictionary(dictionary: exchangeRates)
                exchangeRateMutable[_firstCurrency.coin] = exchangeRate.rate
                onComplete(exchangeRateMutable as! [String : Double])
            }, onFail: {

            })
        }
    }

    func getExchageRate(from:String, to:String, onSuccess:  @escaping (ExchangeRate) -> Void, onFail: @escaping () -> Void ) {
        if let _exchangeRate = exchageRateCached[to] {
            onSuccess(_exchangeRate)
            return
        }

        PersistanceManager.shared.get(from: from, to: to) { exchangeRate in
            guard let _exchangeRate = exchangeRate else {
                RatesRestService.shared.rate(from: from, to: to, onSuccess: { exchangeRate in
                    PersistanceManager.shared.set(exchangeRate: exchangeRate, onComplete: {
                        self.exchageRateCached[from] = exchangeRate
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

    // MARK: - Reservations
    func add(reservation:Reservation, onComplete: () -> Void ) {
        
        PersistanceManager.shared.add(reservation: reservation, onComplete: onComplete)
    }
    
    func getReservations(onComplete: ([Reservation]) -> Void) {
        
        PersistanceManager.shared.getReservations(onComplete: onComplete)
    }
}
