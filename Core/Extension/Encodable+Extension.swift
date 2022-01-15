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
}
