//
//  HttpClient.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 16/01/22.
//

import Foundation
public protocol HttpClient {
    func set(headers: [String: String])
    func request(resource: String, method: HttpMethod, json: Data?, completion: @escaping ((_ result: Result<SuccessResult, ErrorResult>) -> Void))
}

public struct SuccessResult {
    public let success: Bool
    public let statusCode: Int?
    
    public let requestUrl: String
    public let method: HttpMethod
    
    public let data: Data?
    
    public init(
        success: Bool,
        statusCode: Int?,
        requestUrl: String,
        method: HttpMethod,
        data: Data?
    ) {
        self.success = success
        self.statusCode = statusCode
        self.requestUrl = requestUrl
        self.method = method
        self.data = data
    }
}

public enum ErrorResult: Error, Equatable {
    case generalError(code: Int, message: String?)
    case noInternet
    case dataNil
    case parsingFailure
}
