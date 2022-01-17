//
//  HomeViewModel.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 16/01/22.
//

import RxSwift
import RxCocoa

public class HomeViewModel: EXViewModel {
    let didNavigateToEdit = PublishSubject<Void>()
    let didNavigateToDetail = PublishSubject<Void>()
    let didAddPressed = PublishSubject<Void>()
    let didDeleteItem = PublishSubject<Void>()

    let moreOptionItems: [MoreOptionsType] = [
        .read(MoreOptionsModel(icon: UIImage(named: "list"), title: "Lihat")),
        .edit(MoreOptionsModel(icon: UIImage(named: "editing"), title: "Ubah")),
        .delete(MoreOptionsModel(icon: UIImage(named: "bin"), title: "Hapus"))
    ]

    let didItemSelected = PublishSubject<MoreOptionsType>()

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

        self.didItemSelected
            .bind { [weak self] type in
                self?.handleOptionSelected(type: type)
            }.disposed(by: self.disposeBag)

        self.didDeleteItem
            .withLatestFrom(self.didSelectedItem)
            .bind { [weak self] item in
                self?.handleDelete(item: item)
            }.disposed(by: self.disposeBag)

        self.didNavigateToEdit
            .withLatestFrom(self.didSelectedItem)
            .bind { model in
                AppDelegate.container.register(CrudType.self) { _ in .EDIT(model)}
            }.disposed(by: self.disposeBag)

        self.didNavigateToDetail
            .withLatestFrom(self.didSelectedItem)
            .bind { model in
                AppDelegate.container.register(String.self) { _ in model.model.id.orEmpty }
            }.disposed(by: self.disposeBag)

        self.didAddPressed
            .bind { _ in
                AppDelegate.container.register(CrudType.self) { _ in .CREATE(())}
            }.disposed(by: self.disposeBag)
    }

    private func handleDelete(item: PostDao) {
        self.homeUseCase.deletePost(id: item.model.id.orEmpty)
            .subscribe { _ in
                self.fatchData()
            } onError: { _ in
            } onCompleted: {
            } onDisposed: {
            }.disposed(by: self.disposeBag)

    }

    private func handleOptionSelected(type: MoreOptionsType) {
        switch type {
        case .read:
            self.didNavigateToDetail.onNext(())
        case .delete:
            self.didDeleteItem.onNext(())
        case .edit:
            self.didNavigateToEdit.onNext(())
        }
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
