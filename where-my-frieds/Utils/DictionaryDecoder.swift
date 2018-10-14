//
//  DictionaryDecoder.swift
//  where-my-frieds
//
//  Created by Den on 10/4/18.
//  Copyright © 2018 Deniss Kaibagarovs. All rights reserved.
//

import Foundation

class DictionaryDecoder {
    private let jsonDecoder = JSONDecoder()
    
    /// Decodes given Decodable type from given array or dictionary
    func decode<T>(_ type: T.Type, from json: Any) throws -> T where T: Decodable {
        let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
        return try jsonDecoder.decode(type, from: jsonData)
    }
}
