//
//  Data+Extension.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 15/01/22.
//

import Foundation
struct VoidResponse: Codable { }

public extension Data {
    func toObject<T: Codable>(_ type: T.Type) -> T? {
        if type == VoidResponse.self {
            return VoidResponse() as? T
        }
        return try? Json.decoder.decode(type, from: self)
    }
    func toObject<T: Decodable>(type: T.Type) -> T? {
        let response = try? Json.decoder.decode(type, from: self)
        return response
    }
}
