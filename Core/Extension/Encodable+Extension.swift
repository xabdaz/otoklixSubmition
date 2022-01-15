//
//  Encodable+Extension.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 15/01/22.
//

import Foundation
import Foundation
public extension Encodable {
    
    func toJson() -> Data? {
        return try? Json.encoder.encode(self)
    }
    func toValue() -> String {
        return ""
    }
    func getValue<T: Decodable>(values: KeyedDecodingContainer<T>, key: KeyedDecodingContainer<T>.Key) throws -> T? {

        let data = try? values.decodeIfPresent(T.self, forKey: key)
        return data
    }
}
