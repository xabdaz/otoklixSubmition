//
//  EXViewController.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 15/01/22.
//

import UIKit
protocol BaseViewControllerProtocol {
    dynamic func onFinishCoordinator()
}

open class EXViewController: UIViewController {
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil ?? "\(Self.self)", bundle: nibBundleOrNil ?? Bundle.main)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        self.onFinishCoordinator()
    }

    open func onFinishCoordinator() {
        print("please implemented to destroy coordinator")
    }
}
