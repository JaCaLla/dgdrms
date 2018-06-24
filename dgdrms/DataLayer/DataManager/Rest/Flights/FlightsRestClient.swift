//
//  RestClient.swift
//  tempos21test
//
//  Copyright © 2017 08APO0516ja. All rights reserved.
//

import Foundation
import Alamofire

class FlightsRestClient {

    static let shared =  FlightsRestClient()

    private init() {}

    func perform(request urlRequest: URLRequestConvertible,
                 success succeed : @escaping ((Any) -> Void),
                 failure failed : @escaping ((FlightsResponseCode) -> Void)) {

        print("\n↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️")
        print("Starting Request...")
        if let method = urlRequest.urlRequest?.httpMethod {
            print("Method: \(String(describing: method))")

        }
        if let url = urlRequest.urlRequest?.url {
            print("URL: \(String(describing: url))")

        }
        if let headers = urlRequest.urlRequest?.allHTTPHeaderFields {
            print("Headers: \(String(describing: headers))")

        }
        if let body = urlRequest.urlRequest?.httpBody {
            print("Body: \(String(data: body, encoding: .utf8)!)")

        }
        print("↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️\n")

        Alamofire.request(urlRequest).validate(statusCode: 200..<401).responseJSON { response in

            switch response.result {
            case .success:

                print("\n✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅")
                print("Response:")
                print("\(response.debugDescription)")
                print("✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅\n")

                if let resultValue = response.result.value as? JSONDictionary ,
                    let _restResponse = FlightsRestResponseInternal(dictionary: resultValue) {
                    succeed(_restResponse.results as Any)
                } else {
                    FlightsRestClient.printParsingErrorIn(request: urlRequest)
                    failed(FlightsResponseCode.badFormedJSONModel)
                }

            case .failure( _ ):

                FlightsRestClient.printError(response: response)
                failed(FlightsResponseCode.networkError)
            }
        }
    }

    // MARK: - Public Methods

    static func printError(response: DataResponse<Any>) {
        print("\n❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌")
        print("Response:")
        print("\n\(response.debugDescription)")
        print("❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌\n")
    }

    static func printParsingErrorIn(request: URLRequestConvertible) {
        print("\n❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌")
        print("Response from request \(String(describing: request.urlRequest!.url!.debugDescription)) :")
        print("\nError parsing response")
        print("❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌\n")
    }
}
