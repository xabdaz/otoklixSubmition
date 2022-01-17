//
//  OLWithIconCell.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 17/01/22.
//

import UIKit

class OLWithIconCell: EXTableViewCell {

    @IBOutlet weak var container: OLWithIcon!
    @IBOutlet weak var separator: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
