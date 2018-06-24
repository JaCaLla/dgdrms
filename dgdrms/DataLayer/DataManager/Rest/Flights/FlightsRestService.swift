//
//  RestService.Swift
//
//  Created by 08APO0516 on 31/01/2017.
//  Copyright © 2017 08APO0516ja. All rights reserved.
//

import Foundation
import Alamofire

enum FlightsRouter: URLRequestConvertible {
    static let baseURLString = "https://" + AppEnvironment.shared.environment.baseURLFlights

    case Points(Environment?)
    case Point(Environment?,String)
    case Flights(Environment?)

    var method: Alamofire.HTTPMethod {
        switch self {
        case .Points:   return .get
        case .Point:    return .get
        case .Flights:  return  .get
        }
    }

    var version: String {
        return "v1"
    }

    var path: String {

        switch self {
        case .Points:return "/points"
        case .Point( _ , let pointId): return "/points/\(pointId)"
        case .Flights( _): return "/"
        }
    }

    func resolveURLRequest(environment:Environment? = nil) -> URLRequest {

        var url = URL(string: FlightsRouter.baseURLString)!
        if let _enviroment = environment {
            url = URL(string: "https://" + _enviroment.baseURLFlights)!
        }

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue

        return urlRequest
    }

    func asURLRequest() throws -> URLRequest {

        let url = URL(string: FlightsRouter.baseURLString)!
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue

        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

        switch self {
        case .Points, .Point, .Flights:
            return try Alamofire.JSONEncoding.default.encode(urlRequest, with: nil)
        }
    }
}

class  FlightsRestService {

    static let shared =  FlightsRestService()

    private init() {} //This prevents others from using the default '()' initializer for this class.

    struct JSONKey {
        static let lists = "list"
    }

    var environment:Environment? // This is only for testing purposes

    func reset() {
        self.environment = nil
    }

    func getFlights(onSuccess: @escaping ([Flight]) -> Void, onFailed: @escaping (FlightsRestResponse) -> Void ) {

        let request = FlightsRouter.Flights(self.environment)
        FlightsRestClient.shared.perform(request: request, success: { response in
            if let _flights = Flight.getFlightsFrom(array: response as? [JSONDictionary]) {
                onSuccess(_flights)
            } else {
                FlightsRestClient.printParsingErrorIn(request: request)
                onFailed(FlightsRestResponse(responseCode:FlightsResponseCode.badFormedJSONModel))
            }
        }) { responseCode in
            onFailed(FlightsRestResponse(responseCode:FlightsResponseCode.networkError))
        }
    }
    
    func getCurrencies(onSuccess: @escaping ([Currency]) -> Void, onFailed: @escaping (FlightsRestResponse) -> Void ) {
        
        let request = FlightsRouter.Flights(self.environment)
        FlightsRestClient.shared.perform(request: request, success: { response in
            onSuccess( Currency.getCurrenciesFrom(array: response as? [JSONDictionary]) )
        }) { responseCode in
            onFailed(FlightsRestResponse(responseCode:FlightsResponseCode.networkError))
        }
    }
 
    /*
     func getPoints(onSuccess: @escaping ([Point]) -> Void, onFailed: @escaping (Error) -> Void ) {

     let request = FlightsRouter.Points(self.environment)
     RestClient.shared.perform(request: request, success: { jsonDictionary in
     guard let _points = jsonDictionary[JSONKey.lists] as? [JSONDictionary] else {
     onFailed(APIError.unknownResponse)
     return
     }
     onSuccess(self._jsonPoints2ArrayOfPoints(jsonPoints: _points))
     }) { error in
     onFailed(error)
     }
     }

     func getPoint(identifier:String,onSuccess: @escaping (Point) -> Void, onFailed: @escaping (Error) -> Void ) {

     let request = FlightsRouter.Point(self.environment,identifier)
     RestClient.shared.perform(request: request, success: { jsonDictionary in
     guard let _point = Point(jsonDictionary:jsonDictionary) else {
     onFailed(APIError.unknownResponse)
     return
     }
     onSuccess(_point)
     }) { error in
     onFailed(error)
     }
     }

     // MARK: - Private/Internal
     func _jsonPoints2ArrayOfPoints(jsonPoints: [JSONDictionary]) -> [Point] {

     let points:[Point] = jsonPoints.map {
     let jsonPoint:JSONDictionary = $0
     return Point(jsonDictionary: jsonPoint)!
     }
     return points
     }
     */
}
