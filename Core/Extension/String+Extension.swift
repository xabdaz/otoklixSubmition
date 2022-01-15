//
//  String+Extension.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 15/01/22.
//

import Foundation
public extension Optional where Wrapped == String {
    var orEmpty: String {
        return self ?? ""
    }
}
