//
//  UIViewController+Extension.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 17/01/22.
//

import UIKit
import FittedSheets
import RxSwift
import RxCocoa

extension UIViewController {
    func presentOnTop(
        _ viewController: UIViewController,
        animated: Bool = true,
        style: UIModalPresentationStyle = .fullScreen,
        witNavigation isNavigation: Bool = true
    ) {
        var topViewController = self
        if let presentedViewController = topViewController.presentedViewController {
            topViewController = presentedViewController
        }
        
        if isNavigation {
            let navigation = UINavigationController.create(vc: viewController, true)
            navigation.modalPresentationStyle = style
            topViewController.present(navigation, animated: animated)
        } else {
            viewController.modalPresentationStyle = style
            topViewController.present(viewController, animated: animated)
        }
    }
    
    func presentSheet(_ viewController: UIViewController, dismissManual: Bool) {
        presentSheet(
            viewController,
            dismissOnBackgroundTap: !dismissManual,
            dismissOnPan: !dismissManual,
            dismissOnSwipeDown: !dismissManual,
            usePoni: !dismissManual
        )
    }
    
    func presentSheet(
        _ viewController: UIViewController,
        withNavigation isNavigation: Bool = false,
        dismissOnBackgroundTap: Bool = true,
        dismissOnPan: Bool = true,
        sizes: [SheetSize] = [],
        dismissOnSwipeDown: Bool = true,
        usePoni: Bool = true
    ) {
        let sheet = SheetViewController(controller: viewController)
        sheet.extendBackgroundBehindHandle = usePoni
        sheet.adjustForBottomSafeArea = true
        sheet.dismissOnBackgroundTap = dismissOnBackgroundTap
        sheet.dismissOnPan = dismissOnPan
        sheet.setSizes(sizes)
        
        if dismissOnSwipeDown == false {
            sheet.view.gestureRecognizers?.removeAll()
        }
        
        if usePoni == false {
            sheet.handleColor = .clear
        }
    
        presentOnTop(sheet, animated: false, style: .overFullScreen, witNavigation: isNavigation)
    }
    
    func dismissOnTop(animated: Bool, _ completion: (() -> Void)? = nil) {
        if let navigation = self as? UINavigationController {
            if let sheet = navigation.topViewController?.isSheeted {
                sheet.closeSheet(completion: completion)
            } else if let sheet = navigation.topViewController?.sheeted {
                sheet.closeSheet(completion: completion)
            } else {
                navigation.dismiss(animated: animated, completion: completion)
            }
        } else {
            if let sheet =  self.isSheeted {
                sheet.closeSheet(completion: completion)
            } else if let sheet = self.sheeted {
                sheet.closeSheet(completion: completion)
            } else {
                self.dismiss(animated: animated, completion: completion)
            }
        }
    }

    var sheeted: SheetViewController? {
        guard let vc = self.parent as? SheetViewController else {
            return nil
        }
        return vc
    }

    var isSheeted: SheetViewController? {
        guard let vc = self as? SheetViewController else {
            return nil
        }
        return vc
    }
}
