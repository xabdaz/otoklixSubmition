//
//  HomeUseCase.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 16/01/22.
//

import RxSwift
import RxCocoa

public protocol HomeUseCase: AnyObject {
    func loadData() -> Observable<[PostDao]>
    func deletePost(id: String) -> Observable<PostDao>
    func bindError() -> Observable<NotifStateView>
}

public class EXHomeUseCase: HomeUseCase {

    private let errorState = PublishSubject<NotifStateView>()
    private let restClient: BackendRestClient
    public init(restClient: BackendRestClient) {
        self.restClient = restClient
    }

    public func loadData() -> Observable<[PostDao]> {
        return restClient.request(PostRepository.GetPost())
            .catchError{ [weak self] error in
                self?.handleError(error: error)
                return .never()
            }.map { model -> [PostDao] in
                let item = model.map { PostDao(model: $0) }
                return item
            }.asObservable()
    }

    public func deletePost(id: String) -> Observable<PostDao> {
        return restClient.request(PostRepository.DeleteDetail(id: id))
            .catchError{ [weak self] error in
                self?.handleError(error: error)
                return .never()
            }.map { model -> PostDao in
                let item = PostDao(model: model)
                return item
            }.asObservable()
    }

    public func bindError() -> Observable<NotifStateView> {
        return errorState.asObservable()
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
