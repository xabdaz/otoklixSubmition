//
//  InputCoordinator.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 17/01/22.
//

import Foundation
import FittedSheets
import RxSwift

public class InputCoordinator: EXCoordinator {
    private let disposeBag =  DisposeBag()
    public let viewModel: InputViewModel
    public init(viewModel: InputViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    public override func start() {
        let viewController = InputSheet(viewModel: self.viewModel)
        self.navigation.presentSheet(viewController, sizes: [.halfScreen, .fullScreen])
    }

    public override func setupBinding() {
        self.viewModel.didFinishCoordinator
            .bind(to: self.didFinish)
            .disposed(by: self.disposeBag)

        self.viewModel.didSuccess
            .bind { [weak self] type in
                switch type {
                case .CREATE:
                    self?.didCloseView(animated: true, resultCode: .SAVE, resultData: nil, nil)
                case .EDIT:
                    self?.didCloseView(animated: true, resultCode: .EDIT, resultData: nil, nil)
                default: break
                }
            }.disposed(by: self.disposeBag)
    }

    public override func didCloseView(animated: Bool, resultCode: Int, resultData: String?, _ completion: (() -> Void)?) {
        super.didCloseView(animated: animated, resultCode: resultCode, resultData: resultData, completion)
        self.navigation.closeSheet(completion)
    }
}
