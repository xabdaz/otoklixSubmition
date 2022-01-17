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
        autoregister(DetailCoordinator.self, initializer: DetailCoordinator.init)
        autoregister(InputCoordinator.self, initializer: InputCoordinator.init)
    }

    func registerViewModel() {
        autoregister(HomeViewModel.self, initializer: HomeViewModel.init)
        autoregister(DetailViewModel.self, initializer: DetailViewModel.init)
        autoregister(InputViewModel.self, initializer: InputViewModel.init)
    }

    func registerUseCase() {
        autoregister(HomeUseCase.self, initializer: EXHomeUseCase.init)
        autoregister(DetailUseCase.self, initializer: EXDetailUseCase.init)
        autoregister(InputUseCase.self, initializer: EXInputUseCase.init)
    }

    func registerService() {
        autoregister(BackendRestClient.self, initializer: BackendRestClient.init)
        autoregister(HttpClient.self, initializer: ProductionClient.init)
    }
}
