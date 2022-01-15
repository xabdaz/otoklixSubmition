//
//  HomeCoordinator.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 15/01/22.
//

import Foundation
public class HomeCoordinator: EXCoordinator {
    
    public override func start() {
        let viewController = HomeVC()
        navigation.viewControllers = [viewController]
    }
}
