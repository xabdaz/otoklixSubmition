//
//  InputCoordinator.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 17/01/22.
//

import Foundation
import FittedSheets
public class InputCoordinator: EXCoordinator {
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
    }
}
