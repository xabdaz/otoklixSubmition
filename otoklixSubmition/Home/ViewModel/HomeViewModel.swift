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
    let didSelectedItem = PublishSubject<PostDao>()
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

        self.didSelectedItem
            .filter { $0.model.id != nil }
            .map { $0.model.id! }
            .bind { id in
                AppDelegate.container.register(String.self) { _ in id}
            }.disposed(by: self.disposeBag)
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
