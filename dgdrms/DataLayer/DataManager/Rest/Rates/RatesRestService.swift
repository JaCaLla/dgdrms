//
//  RestService.Swift
//
//  Created by 08APO0516 on 31/01/2017.
//  Copyright © 2017 08APO0516ja. All rights reserved.
//

import Foundation
import Alamofire

enum RatesRouter: URLRequestConvertible {

    static let host = AppEnvironment.shared.environment.baseURLRates
    static let scheme = "https"
    static let baseURLString =  scheme + "://" + host

    case Points(Environment?)
    case Point(Environment?,String)
    case Rate(Environment?,String,String)

    var method: Alamofire.HTTPMethod {
        switch self {
        case .Points:   return .get
        case .Point:    return .get
        case .Rate:  return  .get
        }
    }

    var version: String {
        return "v1"
    }

    var path: String {

        switch self {
        case .Points:return "/points"
        case .Point( _ , let pointId): return "/points/\(pointId)"
        case .Rate: return "/currency"
        }
    }

    struct GetParam {
        static let from = "from"
        static let to   = "to"
    }

    func resolveURLRequest(environment:Environment? = nil) -> URLRequest {

        let url = URL(string: RatesRouter.baseURLString)!

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue

        switch self {
        case .Rate( _, let from, let to):
            var urlComponents = URLComponents()
            urlComponents.scheme = RatesRouter.scheme
            urlComponents.host = RatesRouter.host
            urlComponents.path = path

            let fromQuery = URLQueryItem(name: GetParam.from, value: from)
            let toQuery = URLQueryItem(name: GetParam.to, value: to)
            urlComponents.queryItems = [fromQuery,toQuery]

            var urlRequest = URLRequest(url: urlComponents.url!)

            urlRequest.httpMethod = method.rawValue
            return urlRequest

        default:
            return urlRequest
        }
    }

    func asURLRequest() throws -> URLRequest {

        let url = URL(string: RatesRouter.baseURLString)!
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue

        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

        switch self {
        case .Points, .Point:
            return try Alamofire.JSONEncoding.default.encode(urlRequest, with: nil)
        case .Rate:
            urlRequest = resolveURLRequest()
            return try Alamofire.JSONEncoding.default.encode(urlRequest, with: nil)
        }
    }
    /*
     func resolveURLRequest() -> URLRequest {

     let url = URL(string: BuyRouter.baseURLString)!

     var urlRequest = URLRequest(url: url.appendingPathComponent(path))
     urlRequest.httpMethod = method.rawValue

     switch self {
     case .GetOffers:
     var urlComponents = URLComponents()
     urlComponents.scheme = BuyRouter.scheme
     urlComponents.host = BuyRouter.host
     urlComponents.path = path

     let addressQuery = URLQueryItem(name: "limit", value: "20")
     urlComponents.queryItems = [addressQuery]

     var urlRequest = URLRequest(url: urlComponents.url!)

     urlRequest.httpMethod = method.rawValue
     return urlRequest

     default:
     return urlRequest
     }

     }

     func asURLRequest() throws -> URLRequest {

     var urlRequest = resolveURLRequest()

     switch self {
     case .GetProduct,.GetOffers:
     urlRequest = resolveURLRequest()
     return try Alamofire.JSONEncoding.default.encode(urlRequest, with: nil)
     }
     }
     */
}

class  RatesRestService {

    static let shared =  RatesRestService()

    private init() {} //This prevents others from using the default '()' initializer for this class.

    struct JSONKey {
        static let lists = "list"
    }

    var environment:Environment? // This is only for testing purposes

    func reset() {
        self.environment = nil
    }

    func rate(from:String,to:String,onSuccess: @escaping (ExchangeRate) -> Void, onFailed: @escaping (RatesRestResponse) -> Void ) {

        let request = RatesRouter.Rate(self.environment,from,to)
        RatesRestClient.shared.perform(request: request, success: { response in
            if let _exchangeRate = ExchangeRate(from: from, dictionary: response as? JSONDictionary) {
                onSuccess(_exchangeRate)
            } else {
                onFailed(RatesRestResponse(responseCode:RatesResponseCode.badFormedJSONModel))
            }
        }) { responseCode in
            onFailed(RatesRestResponse(responseCode:RatesResponseCode.networkError))
        }
    }
    /*
     func getCurrencies(onSuccess: @escaping ([Currency]) -> Void, onFailed: @escaping (RatesRestResponse) -> Void ) {

     let request = RatesRouter.Rates(self.environment)
     RatesRestClient.shared.perform(request: request, success: { response in
     onSuccess( Currency.getCurrenciesFrom(array: response as? [JSONDictionary]) )
     }) { responseCode in
     onFailed(RatesRestResponse(responseCode:RatesResponseCode.networkError))
     }
     }*/

    /*
     func getPoints(onSuccess: @escaping ([Point]) -> Void, onFailed: @escaping (Error) -> Void ) {

     let request = RatesRouter.Points(self.environment)
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

     let request = RatesRouter.Point(self.environment,identifier)
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
