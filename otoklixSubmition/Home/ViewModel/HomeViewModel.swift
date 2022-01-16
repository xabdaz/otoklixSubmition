//
//  HomeViewModel.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 16/01/22.
//

import RxSwift
import RxCocoa

public class HomeViewModel: EXViewModel {
    private let disposeBag = DisposeBag()
    let outTableData = BehaviorRelay<[PostDao]>(value: [])
    private let homeUseCase: HomeUseCase
    public init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
        super.init()
        self.setupBinding()
    }
}
extension HomeViewModel {
    func setupBinding() {
        self.homeUseCase.bindError()
            .bind(to: self.stateNotifView)
            .disposed(by: self.disposeBag)
    }

    func fatchData() {
        self.homeUseCase.loadData()
            .subscribe { [weak self] model in
                self?.outTableData.accept(model)
            } onError: { _ in
            } onCompleted: {
            } onDisposed: {
            }.disposed(by: self.disposeBag)

    }
}
