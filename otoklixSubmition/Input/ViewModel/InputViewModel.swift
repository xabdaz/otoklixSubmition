//
//  InputViewModel.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 17/01/22.
//

import RxSwift
import RxCocoa

public class InputViewModel: EXViewModel {
    private let disposeBag = DisposeBag()

    let didData = BehaviorRelay<PostDao?>(value: nil)
    let didSuccess = PublishSubject<CrudType>()

    let inOutTitle = BehaviorRelay<String?>(value: nil)
    let inOutContent = BehaviorRelay<String?>(value: nil)

    let didSavePressed = PublishSubject<Void>()

    private let type: CrudType
    private let useCase: InputUseCase
    public init(type: CrudType, useCase: InputUseCase) {
        self.type = type
        self.useCase = useCase
        super.init()
        self.setupBinding()
    }
}
extension InputViewModel {
    func setupBinding() {
        let didDataNotNill = self.didData.filter { $0 != nil }.map { $0! }
        didDataNotNill
            .map { $0.model.title }
            .bind(to: self.inOutTitle)
            .disposed(by: self.disposeBag)

        didDataNotNill
            .map { $0.getContent() }
            .bind(to: self.inOutContent )
            .disposed(by: self.disposeBag)

        self.didSavePressed
            .bind { [weak self] in
                self?.handleSavePressed()
            }.disposed(by: self.disposeBag)
    }

    private func handleSavePressed() {
        switch type {
        case .EDIT:
            guard let model = didData.value else { return }
            self.handleEdit(model: model)
        case .CREATE:
            self.handleCreate()
        default: break
        }
    }

    private func handleCreate() {
        let params = [
            "title": self.inOutTitle.value.orEmpty,
            "content" : self.inOutContent.value.orEmpty
        ]
        self.useCase.create(params: params as [String: AnyObject])
            .subscribe { [weak self] model in
                self?.didSuccess.onNext(.CREATE(()))
            } onError: { _ in
            } onCompleted: {
            } onDisposed: {
            }.disposed(by: self.disposeBag)
    }

    private func handleEdit(model: PostDao) {
        let params = [
            "title": self.inOutTitle.value.orEmpty,
            "content" : self.inOutContent.value.orEmpty
        ]
        self.useCase.edit(params: params as [String: AnyObject], id: model.model.id.orEmpty)
            .subscribe { [weak self] model in
                self?.didSuccess.onNext(.EDIT(()))
            } onError: { _ in
            } onCompleted: {
            } onDisposed: {
            }.disposed(by: self.disposeBag)

    }

    func fetchData() {
        switch type {
        case let .EDIT(model):
            guard let data = model as? PostDao else {
                return
            }
            self.didData.accept(data)
        default: break
        }
    }
}
