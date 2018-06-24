//
//  AppEnvironment.swift
//  tempos21test
//
//  Created by 08APO0516 on 16/01/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import Foundation

enum Environment: String {
    case debug = "Debug"
    case staging = "Stagging"
    case production = "Release"

    struct FlightsConstantsBaseURL {
        //
        static let debug = "odigeo-testios.herokuapp.com"
        static let stagging = "odigeo-testios.herokuapp.com"
        static let production = "odigeo-testios.herokuapp.com"
    }

    var baseURLFlights: String {
        switch self {
        case .debug: return FlightsConstantsBaseURL.debug
        case .staging: return FlightsConstantsBaseURL.stagging
        case .production: return FlightsConstantsBaseURL.production
        }
    }
    
    struct RatesConstantsBaseURL {
        static let debug = "jarvisstark.herokuapp.com"
        static let stagging = "jarvisstark.herokuapp.com"
        static let production = "jarvisstark.herokuapp.com"
    }
    
    var baseURLRates: String {
        switch self {
        case .debug: return RatesConstantsBaseURL.debug
        case .staging: return RatesConstantsBaseURL.stagging
        case .production: return RatesConstantsBaseURL.production
        }
    }

}

// MARK: - Private
class AppEnvironment {

    static let shared =  AppEnvironment()

    private init() {}

    lazy var environment: Environment = {
        if let configuration = Bundle.main.infoDictionary?["Configuration"] as? String {
            guard let _configuration = Environment(rawValue:configuration) else {
                print("No Environment")
                return Environment.debug
            }
            return _configuration
        }
        return Environment.debug

    }()
}
