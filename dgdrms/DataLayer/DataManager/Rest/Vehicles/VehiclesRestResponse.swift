//
//  RestResponse.swift
//  iMug
//
//  Copyright © 2017 Nestlé S.A. All rights reserved.
//

import Foundation

enum VehiclesResponseCode : Int {
    case badFormedJSONModel = -3
    case unhandledError = -2
    case networkError = -1
    case success = 0
}

class VehiclesRestResponse: JSONDecodable {

    //   var success:Bool = false
    var results:Any?
    var responseCode:VehiclesResponseCode = VehiclesResponseCode.unhandledError


    init(responseCode:VehiclesResponseCode) {
        self.responseCode = responseCode
    }

    required init?(dictionary: JSONDictionary?) {
        guard let _ = dictionary else {
            return nil
        }
    }
    
}
class VehiclesRestResponseInternal: VehiclesRestResponse {

    struct RestResponseKey {
        static let poiList = "poiList"
    }

    required init?(dictionary: JSONDictionary?) {

        super.init(dictionary: dictionary)

        guard let _dictionary = dictionary else { return nil }
        

        if let _results = _dictionary[RestResponseKey.poiList] {
            self.results = _results
        }
    }
}

class RestResponseExternal: VehiclesRestResponse {

    required init?(dictionary: JSONDictionary?) {

        super.init(dictionary: dictionary)

        self.results = dictionary
    }
}
