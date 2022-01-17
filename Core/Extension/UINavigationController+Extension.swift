//
//  UINavigationController+Extension.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 17/01/22.
//

import Foundation

import FittedSheets

extension UINavigationController {
    func setToRoot(window: UIWindow, withAnimation: Bool) {
        if !withAnimation {
            window.rootViewController = self
            window.makeKeyAndVisible()
            return
        }

        if let snapshot = window.snapshotView(afterScreenUpdates: true) {
            self.view.addSubview(snapshot)
            window.rootViewController = self
            window.makeKeyAndVisible()

            UIView.animate(withDuration: 0.4, animations: {
                snapshot.layer.opacity = 0
            }, completion: { _ in
                snapshot.removeFromSuperview()
            })
        }
    }
    
    func setViewRoot(vc: UIViewController, navBarHidden: Bool = true) {
        self.isNavigationBarHidden = navBarHidden
        self.viewControllers = [vc]
    }
    
    func popViewController(animated: Bool, _ completion: (() -> Void)? = nil) {
        popViewController(animated: animated)
        
        if let coordinator = transitionCoordinator, animated {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion?()
            }
        } else {
            completion?()
        }
    }
    
    func closeSheet(_ completion: (() -> Void)? = nil) {
        if let sheet = self.presentedViewController as? SheetViewController {
            sheet.closeSheet(completion: completion)
        } else if let nav = self.presentedViewController as? UINavigationController,
                  let sheet = nav.topViewController as? SheetViewController {
            sheet.closeSheet(completion: completion)
        } else if let sheet = self.topViewController?.isSheeted {
            sheet.closeSheet(completion: completion)
        } else {
            self.dismiss(animated: false, completion: completion)
        }
    }
    
    static func create(vc: UIViewController, _ hiddenNavBar: Bool) -> UINavigationController {
        let navController = UINavigationController(rootViewController: vc)
        navController.navigationBar.isHidden = hiddenNavBar
        return navController
    }
}
