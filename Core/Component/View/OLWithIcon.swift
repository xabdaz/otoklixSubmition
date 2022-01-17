//
//  OLWithIcon.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 17/01/22.
//

import Foundation
import UIKit

@IBDesignable class OLWithIcon: XIBView {
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var labelCell: UILabel!
    @IBOutlet weak var paddingTop: NSLayoutConstraint!
    @IBOutlet weak var paddingBottom: NSLayoutConstraint!
    
    @IBInspectable var title: String? {
        get { labelCell.text }
        set { labelCell.text = newValue}
    }

    @IBInspectable var titleColor: UIColor? {
        get { labelCell.textColor }
        set { labelCell.textColor = newValue }
    }

    @IBInspectable var icon: UIImage? {
        get { return imageCell.image }
        set { imageCell.image = newValue }
    }

    override func setupView() {
    }
}
