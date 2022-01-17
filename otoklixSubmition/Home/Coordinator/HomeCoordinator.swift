//
//  HomeCoordinator.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 15/01/22.
//

import RxSwift
import FittedSheets
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
                self?.navigateToMoreOption()
            }.disposed(by: self.disposeBag)

        self.viewModel.didNavigateToDetail
            .bind { [weak self] in
                self?.navigateToDetail()
            }.disposed(by: self.disposeBag)
    }
}

extension HomeCoordinator {

    func navigateToDetail() {
        let coordinator = AppDelegate.container.resolve(DetailCoordinator.self)
        coordinator?.navigationController = self.navigation
        self.start(coordinator: coordinator)
        
    }

    func navigateToMoreOption() {
        let viewModel = MoreOptionsViewModel(options: viewModel.moreOptionItems)
        let moreOption = MoreOptionsSheet(viewModel: viewModel)
        let sheet = SheetViewController(controller: moreOption)
        viewModel.didItemSelected
            .bind(to: self.viewModel.didItemSelected)
            .disposed(by: self.disposeBag)

        sheet.extendBackgroundBehindHandle = true
        sheet.adjustForBottomSafeArea = true

        navigationController.presentOnTop(sheet, animated: false, style: .overFullScreen)
    }

}
