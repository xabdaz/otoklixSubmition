//
//  InputUseCase.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 17/01/22.
//

import RxSwift
import RxCocoa

public protocol InputUseCase: AnyObject {
    func create(params: [String: AnyObject]) -> Observable<PostDao>
    func edit(params: [String: AnyObject], id: String) -> Observable<PostDao>
    func bindError() -> Observable<NotifStateView>
}
public class EXInputUseCase: InputUseCase {

    private let errorState = PublishSubject<NotifStateView>()
    private let restClient: BackendRestClient
    public init(restClient: BackendRestClient) {
        self.restClient = restClient
    }
    public func create(params: [String : AnyObject]) -> Observable<PostDao> {
        return self.restClient.request(PostRepository.CreatePost(params: params))
            .catchError { [weak self] error in
                self?.handleError(error: error)
                return .never()
            }.map { PostDao(model: $0)}
            .asObservable()
    }
    
    public func edit(params: [String : AnyObject], id: String) -> Observable<PostDao> {
        return self.restClient.request(PostRepository.EditPost(params: params, id: id))
            .catchError { [weak self] error in
                self?.handleError(error: error)
                return .never()
            }.map { PostDao(model: $0)}
            .asObservable()
    }
    
    public func bindError() -> Observable<NotifStateView> {
        self.errorState.asObserver()
    }
    func handleError(error: Error) {
        guard let error = error as? ErrorResult else {
            self.errorState.onNext(.alert(message: "unknow error"))
            return
        }

        switch error {
        case .generalError(code: _, message: let message):
            self.errorState.onNext(.alert(message: message.orEmpty))
        case .noInternet:
            self.errorState.onNext(.alert(message: "No Internet"))
        case .dataNil:
            self.errorState.onNext(.alert(message: "empty Data"))
        case .parsingFailure:
            self.errorState.onNext(.alert(message: "Parsing Error"))
        }
    }
    
}
