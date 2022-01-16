//
//  MockupClient.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 16/01/22.
//

import Foundation
public class MockupClient: HttpClient {
    
    private var headers = [String: String]()
    public func set(headers: [String: String]) {
        self.headers = headers
    }

    func getDataPost() -> Data {
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "list", ofType: "json")
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped) else {
            return Data()
        }
        return data
    }

    public func request(resource: String, method: HttpMethod, json: Data?, completion: @escaping ((Result<SuccessResult, ErrorResult>) -> Void)) {
        switch resource {
        case "posts":
            let data = self.getDataPost()
            let result = SuccessResult(
                success: true,
                statusCode: 200,
                requestUrl: resource,
                method: method,
                data: data
            )
            completion(.success(result))
        default:
            completion(.failure(.generalError(code: 404, message: "Url Not Faund")))
        }
    }
    
    
}
