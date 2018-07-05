//
//  RestService.Swift
//
//  Created by 08APO0516 on 31/01/2017.
//  Copyright © 2017 08APO0516ja. All rights reserved.
//

import Foundation
import Alamofire

enum VehiclesRouter: URLRequestConvertible {

    static let host = "poi-api.mytaxi.com"
    static let scheme = "https"
    static let baseURLString =  scheme + "://" + host

    case Vehicles(BoundingBox)

    var method: Alamofire.HTTPMethod {
        switch self {
        case .Vehicles:  return  .get
        }
    }

    var version: String {
        return "v1"
    }

    var path: String {

        switch self {
        case .Vehicles( _ ): return "/PoiService/poi/\(version)"
        }
    }

    func resolveURLRequest() -> URLRequest {
        
        let url = URL(string: VehiclesRouter.baseURLString)!
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .Vehicles ( let boundingBox):
            var urlComponents = URLComponents()
            urlComponents.scheme = VehiclesRouter.scheme
            urlComponents.host = AppEnvironment.shared.environment.baseURLVehicles
            urlComponents.path = path
            urlComponents.queryItems = boundingBox.queryItems()
            
            var urlRequest = URLRequest(url: urlComponents.url!)
            
            urlRequest.httpMethod = method.rawValue
            return urlRequest
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        
        var urlRequest = resolveURLRequest()
        
        switch self {
        case .Vehicles:
            urlRequest = resolveURLRequest()
            return try Alamofire.JSONEncoding.default.encode(urlRequest, with: nil)
        }
    }
}

class  VehiclesRestService {

    static let shared =  VehiclesRestService()

    private init() {} //This prevents others from using the default '()' initializer for this class.

    func reset() {
   
    }

    func getVehicles(boundingBox:BoundingBox,
                     onSuccess: @escaping ([Poi]) -> Void,
                     onFailed: @escaping (VehiclesRestResponse) -> Void ) {

        let request = VehiclesRouter.Vehicles(boundingBox)
        VehiclesRestClient.shared.perform(request: request, success: { response in
            if let _pois = Poi.getPoiFrom(array: response as? [JSONDictionary]) {
                onSuccess(_pois)
            } else {
                VehiclesRestClient.printParsingErrorIn(request: request)
                onFailed(VehiclesRestResponse(responseCode:VehiclesResponseCode.badFormedJSONModel))
            }
        }) { responseCode in
            onFailed(VehiclesRestResponse(responseCode:VehiclesResponseCode.networkError))
        }
    }
}
