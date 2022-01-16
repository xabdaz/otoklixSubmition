//
//  ProductionClient.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 16/01/22.
//

import Foundation
public class ProductionClient: HttpClient {
    
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
        guard let url = URL(string: resource) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if method == .post {
            request.httpBody = json
        } else {
            
        }
        for head in self.headers {
            request.addValue(head.value, forHTTPHeaderField: head.key)
        }
        URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard let `self` = self else { return }
            if error == nil {
                guard let data = data else {
                    return
                }
                self.log(data: data, url: resource)
                let str = String(data: data, encoding: .utf8)
                completion(.success(self.getResponse(200, resource, method, str)))
            } else {
                // MARK: Error is Hardcode
                completion(.failure(.generalError(code: 404, message: "unknow Error")))
            }
        }.resume()
    }

    private func getResponse(_ code: Int, _ resource: String, _ method: HttpMethod, _ data: String?) -> SuccessResult {
        return SuccessResult(
            success: true,
            statusCode: 200,
            requestUrl: resource,
            method: method,
            data: data?.data(using: .utf8)
        )
    }

    func log(data: Data, url: String) {
        print("[RESPONSE] -> \(url)")
        guard let object = try? JSONSerialization.jsonObject(with: data, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyString = String(data: data, encoding: .utf8) else {
                  return
              }
        print(prettyString)
    }
}
