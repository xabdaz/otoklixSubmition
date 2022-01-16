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
        registerUseCase()
        registerService()
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

    func registerUseCase() {
        autoregister(HomeUseCase.self, initializer: EXHomeUseCase.init)
    }

    func registerService() {
        autoregister(BackendRestClient.self, initializer: BackendRestClient.init)
        autoregister(HttpClient.self, initializer: ProductionClient.init)
    }
}
