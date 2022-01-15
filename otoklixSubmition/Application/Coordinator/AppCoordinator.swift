//
//  AppCoordinator.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 15/01/22.
//

import RxSwift
import UIKit

public class AppCoordinator: EXCoordinator {
    private var window = UIWindow(frame: UIScreen.main.bounds)

    public override func start() {
        window.makeKeyAndVisible()
    }
}
