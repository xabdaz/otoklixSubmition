//
//  DetailCoordinator.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 17/01/22.
//

import Foundation
public class DetailCoordinator: EXCoordinator {
    public let viewModel: DetailViewModel
    public init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
    }
    public override func start() {
        let viewController = DetailPostVC(viewModel: self.viewModel)
        self.navigation.pushViewController(viewController, animated: true)
    }
}
