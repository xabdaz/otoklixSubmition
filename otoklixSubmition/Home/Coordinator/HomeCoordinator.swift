//
//  HomeCoordinator.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 15/01/22.
//

import Foundation
public class HomeCoordinator: EXCoordinator {
    private let viewModel: HomeViewModel

    public init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    public override func start() {
        let viewController = HomeVC(viewModel: viewModel)
        navigation.viewControllers = [viewController]
    }
}
