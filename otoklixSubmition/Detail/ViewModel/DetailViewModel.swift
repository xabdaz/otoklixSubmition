//
//  DetailViewModel.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 17/01/22.
//

import RxSwift
import RxCocoa

public class DetailViewModel: EXViewModel {

    // MARK: Output
    let outContent = BehaviorRelay<String?>(value: nil)
    let outTitle = BehaviorRelay<String?>(value: nil)
    
    let didData = PublishSubject<DetailDao>()

    private let disposeBag = DisposeBag()
    private let detailUseCase: DetailUseCase
    private let id: String
    public init(detailUsecase: DetailUseCase, id: String) {
        self.detailUseCase = detailUsecase
        self.id = id
        super.init()
        self.setupBinding()
    }
}

extension DetailViewModel {
    func setupBinding() {
        self.detailUseCase.bindError()
            .bind(to: self.stateNotifView)
            .disposed(by: self.disposeBag)

        self.didData.map { $0.getContent() }
        .bind(to: self.outContent)
        .disposed(by: self.disposeBag)
    }

    func fetchData() {
        self.detailUseCase.loadData(id: self.id)
            .subscribe { [weak self] model in
                self?.didData.onNext(model)
            } onError: { _ in
            } onCompleted: {
            } onDisposed: {
            }.disposed(by: self.disposeBag)

    }
}
