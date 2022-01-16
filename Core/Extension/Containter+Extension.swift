//
//  Containter+Extension.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 15/01/22.
//

import Foundation
import Swinject
import SwinjectAutoregistration
extension Container {
    func registerDependencies() {
        registerCoordinator()
        registerViewModel()
    }
}
public extension Container {
    func registerCoordinator() {
        autoregister(AppCoordinator.self, initializer: AppCoordinator.init)
        autoregister(HomeCoordinator.self, initializer: HomeCoordinator.init)
    }

    func registerViewModel() {
        autoregister(HomeViewModel.self, initializer: HomeViewModel.init)
    }
}
