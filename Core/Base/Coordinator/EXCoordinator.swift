//
//  EXCoordinator.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 15/01/22.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

public protocol Coordinator: AnyObject {
    dynamic  var navigationController: UINavigationController { get set }
    dynamic var parentCoordinator: Coordinator? { get set }

    dynamic func start()
    dynamic func setupBinding()

    dynamic func start(coordinator: Coordinator?)
    dynamic func didFinish(coordinator: Coordinator)
    dynamic func removeChildCoordinators()
    dynamic func didCloseView(
        animated: Bool,
        resultCode: Int,
        resultData: String?,
        _ completion: (() -> Void)?
    )
}
open class EXCoordinator: NSObject, Coordinator {
    open var navigationController: UINavigationController = UINavigationController()
    
    public var childCoordinators = [Coordinator]()
    open var parentCoordinator: Coordinator?

    public var onRelease: ((_ resultCode: Int, _ data: String?) -> Void)?
    public var resultCode: Int = CoordinatorResult.CANCEL
    public var resultData: String?
    
    public override init() {
        super.init()
        self.setupBinding()
    }

    open func start() {
        fatalError("Start method should be implemented.")
    }

    open func setupBinding() { }
    
    open func start(coordinator: Coordinator?) {
        if let coordinator = coordinator {
            self.childCoordinators += [coordinator]
            coordinator.parentCoordinator = self
            coordinator.start()
        } else {
            #if DEBUG
            fatalError("Coordinator is nil")
            #endif
        }
    }
    
    open func didFinish(coordinator: Coordinator) {
        if let index = self.childCoordinators.firstIndex(where: { $0 === coordinator }) {
            self.childCoordinators.remove(at: index)
        }
    }
    
    open func removeChildCoordinators() {
        self.childCoordinators.forEach { $0.removeChildCoordinators() }
        self.childCoordinators.removeAll()
    }
    
    open func didCloseView(animated: Bool, resultCode: Int, resultData: String?, _ completion: (() -> Void)?) {
        self.resultCode = resultCode
        self.resultData = resultData
    }
    
    
}
public extension EXCoordinator {
    var navigation: UINavigationController {
        guard let navigation = navigationController.presentedViewController as? UINavigationController else {
            return self.navigationController
        }
        return navigation
    }

    var didFinish: Binder<Void> {
        return Binder(self) { `self`, _ in
             self.parentCoordinator?.didFinish(coordinator: self)
        }
    }
}
