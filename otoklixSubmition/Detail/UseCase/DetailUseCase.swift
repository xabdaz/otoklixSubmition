//
//  DetailUseCase.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 17/01/22.
//

import RxSwift
import RxCocoa
public protocol DetailUseCase: AnyObject {
    func loadData(id: String) -> Observable<DetailDao>
    func bindError() -> Observable<NotifStateView>
}

public class EXDetailUseCase: DetailUseCase {
    private let errorState = PublishSubject<NotifStateView>()
    private let restClient: BackendRestClient
    public init(restClient: BackendRestClient) {
        self.restClient = restClient
    }

    public func loadData(id: String) -> Observable<DetailDao> {
        return self.restClient.request(PostRepository.GetDetail(id: id))
            .catchError{ [weak self] error in
                self?.handleError(error: error)
                return .never()
            }.map { DetailDao(model: $0) }
            .asObservable()
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
