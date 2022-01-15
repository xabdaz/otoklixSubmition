//
//  CoordiantorResult.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 15/01/22.
//

import Foundation
public typealias CoordinatorResult = Int
public extension CoordinatorResult {
    static let CANCEL = 0
    static let OK = 1
    static let DELETE = 2
    static let SAVE = 3
    static let EDIT = 4
}

public struct CoordinatorData<Data: Codable>: Codable {
    let data: Data?
}
