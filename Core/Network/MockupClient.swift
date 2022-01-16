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

    func getData() -> Data {
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
            let data = self.getData()

            let resource = try? JSONDecoder().decode(PostResponse.self, from: data)
            let value = resource?[safe: 1]?.id
            print("value test", value)
            completion(.failure(.dataNil))
        default:
            completion(.failure(.generalError(code: 404, message: "Url Not Faund")))
        }
    }
    
    
}
