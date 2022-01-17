//
//  HomeCoordinator.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 15/01/22.
//

import RxSwift
public class HomeCoordinator: EXCoordinator {
    private let disposeBag = DisposeBag()
    private let viewModel: HomeViewModel

    public init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    public override func start() {
        let viewController = HomeVC(viewModel: viewModel)
        navigation.viewControllers = [viewController]
    }

    public override func setupBinding() {
        self.viewModel.didSelectedItem
            .bind { [weak self] _ in
                self?.navigateToDetail()
            }.disposed(by: self.disposeBag)
    }
}

extension HomeCoordinator {

    func navigateToDetail() {
        let viewController = DetailPostVC()
        self.navigation.pushViewController(viewController, animated: true)
    }
}
