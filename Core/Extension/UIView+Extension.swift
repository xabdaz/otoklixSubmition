//
//  UIView+Extension.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 17/01/22.
//

import UIKit
public extension UIView {
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)

        if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            return view
        }
        fatalError("Runtime Error: XIB -> loadNib cannot to casting to UIView")
    }
}
