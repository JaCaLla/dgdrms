//
//  JSONDecodable.swift
//  Borders
//
//  Created by Guillermo Gonzalez on 24/01/16.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String: AnyObject]

protocol JSONDecodable {
    init?(dictionary: JSONDictionary?)
}

func decode<T: JSONDecodable>(_ dictionaries: [JSONDictionary]) -> [T] {
    return dictionaries.flatMap { T(dictionary: $0) }
}

func decode<T: JSONDecodable>(_ dictionary: JSONDictionary) -> T? {
    return T(dictionary: dictionary)
}

func decode<T:JSONDecodable>(_ data: Data) -> [T]? {
    guard let JSONObject = try? JSONSerialization.jsonObject(with: data, options: []),
        let dictionaries = JSONObject as? [JSONDictionary] else { return nil }
    let objects: [T] = decode(dictionaries)
    return objects
}
