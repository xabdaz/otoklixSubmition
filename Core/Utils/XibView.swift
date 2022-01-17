//
//  XibView.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 17/01/22.
//

import UIKit

class XIBView: UIView {
    var view: UIView!

    static var identifier: String {
        return String(describing: type(of: self))
    }

    override init(frame: CGRect) {
       super.init(frame: frame)
       xibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
       xibSetup()
    }

    @objc dynamic func setupView() {
    }
}

private extension XIBView {
    func xibSetup() {
        backgroundColor = UIColor.clear
        view = loadNib()
        view.frame = bounds
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": view!]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": view!]))
        setupView()
    }
}
