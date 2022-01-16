//
//  BackEndRestClient.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 16/01/22.
//

import Foundation
import RxSwift
import RxCocoa

public class BackendRestClient {
    private let httpClient: HttpClient
    
    public init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }
    
    func request<T: Codable>(_ request: ApiRequest<T>) -> Single<T>{
        return Single.create { [weak self] single in
            guard let self = self else { return Disposables.create() }
            self.httpClient.set(headers: request.header)
            let resource: String = "https://limitless-forest-49003.herokuapp.com/\(request.resource)"
            self.httpClient.request(
                resource: resource,
                method: request.method,
                json: request.json) { result in
                    switch result {
                    case let .success(result):
                        self.validate(
                            response: result,
                            for: request,
                            single: single
                        )
                    case let .failure(error):
                        single(.error(error))
                    }
                }
            return Disposables.create()
        }
    }
    
    private func validate<T: Codable>(response: SuccessResult, for request: ApiRequest<T>, single: Single<T>.SingleObserver) {
        guard response.success && response.statusCode == request.expectedCode else {
            let error = ErrorResult.generalError(code: 400, message: "Error State and Expect Code")
            single(.error(error))
            return
        }
        guard let parsedResponse = response.data?.toObject(T.self) else {
            let error = ErrorResult.generalError(code: 401, message: "Parsing Model")
            single(.error(error))
            return
        }
        single(.success(parsedResponse))
    }
}
