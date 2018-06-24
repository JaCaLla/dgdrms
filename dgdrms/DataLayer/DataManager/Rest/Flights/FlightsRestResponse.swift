//
//  RestResponse.swift
//  iMug
//
//  Copyright © 2017 Nestlé S.A. All rights reserved.
//

import Foundation

enum FlightsResponseCode : Int {
    case badFormedJSONModel = -3
    case unhandledError = -2
    case networkError = -1
    case success = 0
    case invalidSDKRecipeNumber = 10000
    case accountDoesNotExist = 10004
    case accountAlreadyExist = 10003
    case chatExists = 150000
}

class FlightsRestResponse: JSONDecodable {

    //   var success:Bool = false
    var results:Any?
    var responseCode:FlightsResponseCode = FlightsResponseCode.unhandledError
    /*
     init(success:Bool) {
     self.success = success
     self.responseCode = ResponseCode.success
     }
     */

    init(responseCode:FlightsResponseCode) {
        //   self.success = false
        self.responseCode = responseCode
    }

    required init?(dictionary: JSONDictionary?) {
        guard let _ = dictionary else {
            return nil
        }
    }
    /*
     func isSuccess() -> Bool {
     return self.success
     }
     */
    /*
     func isBadFormedJSONModel() -> Bool {
     return self.responseCode == .badFormedJSONModel
     }

     func isNetworkError() -> Bool {
     return self.responseCode == .networkError
     }

     func isAccountDoesNotExist() -> Bool {
     return self.responseCode == .accountDoesNotExist
     }

     func isAccountAlreadyExist() -> Bool {
     return self.responseCode == .accountAlreadyExist
     }*/
}
class FlightsRestResponseInternal: FlightsRestResponse {

    struct RestResponseKey {
        // static let success = "success"
        static let results = "results"
        // static let error = "error"
        // static let code = "code"
    }

    required init?(dictionary: JSONDictionary?) {

        super.init(dictionary: dictionary)

        guard   let _dictionary = dictionary/*,
             let _success    = _dictionary[RestResponseKey.success] as? Bool*/
            else {
                return nil
        }
        //self.success      = _success

        if let _results = _dictionary[RestResponseKey.results] {
            self.results = _results
        }
        /*
         if let _error = _dictionary[RestResponseKey.error],
         let _responseCode = _error[RestResponseKey.code] as? Int,
         let code = ResponseCode(rawValue:_responseCode){
         self.responseCode = code
         }*/
    }
    /*
     func isInvalidSDKRecipeNumber() -> Bool {
     return self.responseCode == ResponseCode.invalidSDKRecipeNumber
     }

     func isAccountDoesNotExists() -> Bool {
     return self.responseCode == ResponseCode.accountDoesNotExist
     }

     func isAccountAlreadyExists() -> Bool {
     return self.responseCode == ResponseCode.accountAlreadyExist
     }*/
}

class RestResponseExternal: FlightsRestResponse {

    required init?(dictionary: JSONDictionary?) {

        super.init(dictionary: dictionary)

        self.results = dictionary
    }
}
