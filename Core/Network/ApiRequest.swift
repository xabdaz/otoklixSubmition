//
//  ApiRequest.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 16/01/22.
//

import Foundation
open class ApiRequest<T: Codable> {
    public let method: HttpMethod
    public let resource: String
    public let expectedCode: Int
    public let json: Data?
    public let header: [String: String]
    public init(
        resource: String,
        method: HttpMethod = .get,
        expectedCode: Int = 200,
        form: [String:String]? = nil,
        json: Data? = nil,
        header: [String: String] = [:]
    ) {
        self.resource = resource
        self.method = method
        self.expectedCode = expectedCode
        self.json = json
        self.header = header
    }
}
