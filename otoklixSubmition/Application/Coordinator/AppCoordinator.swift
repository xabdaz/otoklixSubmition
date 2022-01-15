//
//  AppCoordinator.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 15/01/22.
//

import RxSwift
import UIKit

public class AppCoordinator: EXCoordinator {
    var window = UIWindow(frame: UIScreen.main.bounds)

    public override func start() {
        window.makeKeyAndVisible()
        self.navigateToHome()
    }

    private func navigateToHome() {
        self.removeChildCoordinators()
        let coordinator = AppDelegate.container.resolve(HomeCoordinator.self)
        self.start(coordinator: coordinator)

        ViewControllerUtils.setRootViewController(
            window: window,
            viewController: coordinator?.navigationController ?? UIViewController(),
            withAnimation: true
        )
    }
}
