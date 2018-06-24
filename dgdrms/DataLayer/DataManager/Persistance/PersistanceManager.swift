//
//  PersistanceManager.swift
//  tempos21test
//
//  Created by 08APO0516 on 17/01/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import Foundation
import CoreData

class  PersistanceManager {

    static let shared =  PersistanceManager()
    
    // MARK: - Private attributes
    private struct Entity {
        static let  user = "CDUser"
        static let  currency = "CDCurrency"
        static let exchangeRate = "CDExchangeRate"
    }

    private let persistentContainerName = "dgdrms"
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: persistentContainerName)
        container.loadPersistentStores { ( storeDescription, error) in
            print(storeDescription)
            if let _error = error {
                fatalError("Unresolved error \(_error), \(String(describing: _error._userInfo))")
            }
        }
        return container
    }()

    private init() {} //This prevents others from using the default '()' initializer for this class.

    func reset() {
       self.resetUser()
       self.resetCurrencies()
       self.resetExchangeRate()
    }
    
    // MARK: - User
    func resetUser() {
        let context = persistentContainer.viewContext
        
        let deleteFetchUser = NSFetchRequest<NSFetchRequestResult>(entityName: Entity.user)
        let deleteRequestUser = NSBatchDeleteRequest(fetchRequest: deleteFetchUser)
        do {
            try context.execute(deleteRequestUser)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    
    func set(user:User, onComplete: () -> Void ) {
        
        guard isUserSet() == false else {
            resetUser()
            set(user: user, onComplete: onComplete)
            return
        }
        
        let context = persistentContainer.viewContext
        let cdUser = CDUser(entity: CDUser.entity(), insertInto: context)
        cdUser.set(user:user)
        saveContext()
        onComplete()
    }
    
    func getUser(onComplete: (User?) -> Void) {
        let context = persistentContainer.viewContext
        do {
            let cdUser = try context.fetch(CDUser.fetchRequest())
            guard cdUser.count == 1 else { onComplete(nil); return}
            let users:[User] = cdUser.map {
                let cdUser:CDUser = $0 as! CDUser
                let _user = User(name: cdUser.name!,
                                   surename: cdUser.surename!)
                return _user
            }
            onComplete(users[0])
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            onComplete(nil)
        }
    }
    
    func isUserSet() -> Bool {
        
        return getUserCount() == 1
    }
    
    func getUserCount() -> Int {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Entity.user)
        do {
            let users:Int = try context.count(for: fetchRequest)
            return users
        } catch {
            return 0
        }
    }
    
    // MARK: - Currencies
    func resetCurrencies() {
        let context = persistentContainer.viewContext
        
        let deleteFetchUser = NSFetchRequest<NSFetchRequestResult>(entityName: Entity.currency)
        let deleteRequestUser = NSBatchDeleteRequest(fetchRequest: deleteFetchUser)
        do {
            try context.execute(deleteRequestUser)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    
    func getCurrencyCount() -> Int {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Entity.currency)
        do {
            let users:Int = try context.count(for: fetchRequest)
            return users
        } catch {
            return 0
        }
    }
    
    func getCurrencies(onComplete: ([Currency]) -> Void) {
        let context = persistentContainer.viewContext
        do {
            let cdCurrency = try context.fetch(CDCurrency.fetchRequest())
            let currencies:[Currency] = cdCurrency.map {
                let cdCurrency:CDCurrency = $0 as! CDCurrency
                let _currency = Currency(coin: cdCurrency.coin!)
                return _currency
            }
            onComplete(currencies)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            onComplete([])
        }
    }
    
    func set(currencies:[Currency], onComplete: @escaping () -> Void ) {
        self.resetCurrencies()
        self.add(currencies: currencies, onComplete: onComplete)
    }
    
    private func add(currency:Currency, onComplete: () -> Void ) {
        let context = persistentContainer.viewContext
        let cdCurrency = CDCurrency(entity: CDCurrency.entity(), insertInto: context)
        cdCurrency.set(currency: currency)
        saveContext()
        onComplete()
    }
    
    private func add(currencies:[Currency], onComplete: @escaping () -> Void ) {
        
        guard let _firstCurrency = currencies.first  else { onComplete(); return }
            
        let _pendingCurrencies = Array(currencies[1..<currencies.count])
        self.add(currency:_firstCurrency,onComplete: {
            self.add(currencies:_pendingCurrencies,onComplete:onComplete)
        })
    }
    
    // MARK: - Exchange rates
    func resetExchangeRate() {
        let context = persistentContainer.viewContext
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: Entity.exchangeRate)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    
    func set(exchangeRate:ExchangeRate, onComplete: () -> Void ) {
        let context = persistentContainer.viewContext
        let cdExchangeRate = CDExchangeRate(entity: CDExchangeRate.entity(), insertInto: context)
        cdExchangeRate.set(exchangeRate: exchangeRate)
        saveContext()
        onComplete()
    }
    
    func get(from:String,to:String, onComplete: (ExchangeRate?) -> Void) {
        let context = persistentContainer.viewContext
        do {
            let fetchRequest : NSFetchRequest<CDExchangeRate> = CDExchangeRate.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "from == %@ AND to == %@", from, to)
            let fetchedResults = try context.fetch(fetchRequest)
            guard let _cdExchangeRate = fetchedResults.first  else {
                onComplete(nil)
                return
            }
            onComplete(ExchangeRate(from: _cdExchangeRate.from!, to: _cdExchangeRate.to!, rate: _cdExchangeRate.rate))
        } catch {
            onComplete(nil)
            print ("fetch task failed", error)
        }
    }
    
    // MARK: - Point
    func add(point:Point, onComplete: () -> Void ) {
        let context = persistentContainer.viewContext
        let cdPoint = CDPoint(entity: CDPoint.entity(), insertInto: context)
        cdPoint.set(point:point)
        saveContext()
        onComplete()
    }
    
    func add(points:[Point], onComplete: @escaping () -> Void ) {
        
        if let _firstPoint = points.first {
            
            let _pendingCustomRecipes = Array(points[1..<points.count])
            
            self.add(point:_firstPoint,onComplete: {
                self.add(points:_pendingCustomRecipes,onComplete:onComplete)
            })
        } else {
            onComplete()
        }
    }
    
    func update(source:Point,destination:Point, onComplete: (Bool) -> Void) {
        let context = persistentContainer.viewContext
        do {
            let fetchRequest : NSFetchRequest<CDPoint> = CDPoint.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", source.identifier)
            let fetchedResults = try context.fetch(fetchRequest)
            guard let _cdPoint = fetchedResults.first  else {
                onComplete(false)
                return
            }
            _cdPoint.set(point: destination)
            self.saveContext()
            onComplete(true)
        } catch {
            onComplete(false)
            print ("fetch task failed", error)
        }
    }

    

    func isEmpty() -> Bool {

        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDPoint")
        do {
            let points:Int = try context.count(for: fetchRequest)
            return points == 0
        } catch {
            return false
        }
    }

    func getPoints(onComplete: ([Point]) -> Void) {
        let context = persistentContainer.viewContext
        do {
            let cdPoints = try context.fetch(CDPoint.fetchRequest())
            let points:[Point] = cdPoints.map {
                let cdPoint:CDPoint = $0 as! CDPoint
                let _point = Point(identifier: cdPoint.id!,
                                   title: cdPoint.title!,
                                   address: cdPoint.address!,
                                   transport: cdPoint.transport!,
                                   email: cdPoint.email!,
                                   geocoordinates: cdPoint.geocoordinates!,
                                   description: cdPoint.desc!,
                                   phone: cdPoint.phone!)
                return _point
            }
            onComplete(points)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            onComplete([])
        }
    }

    func getDetail(point:Point, onComplete: (Point?) -> Void) {

        let context = persistentContainer.viewContext
        do {
            let fetchRequest : NSFetchRequest<CDPoint> = CDPoint.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", point.identifier)
            let fetchedResults = try context.fetch(fetchRequest)
            guard let _cdPoint = fetchedResults.first  else {
                onComplete(nil)
                return
            }

            let _point = _cdPoint.get()
            onComplete( _point.hasDetail() ? _point : nil )
        } catch {
            onComplete(nil)
            print ("fetch task failed", error)
        }
    }

    // MARK: - Private/Internal
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let _error = error
                fatalError("Unresolved error \(_error), \(String(describing: _error._userInfo))")
            }
        }
    }
    
    

}
