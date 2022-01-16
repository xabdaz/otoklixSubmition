//
//  PostCell.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 16/01/22.
//

import UIKit

class PostCell: EXTableViewCell {

    @IBOutlet weak var contentLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    public func setContent(item: PostDao) {
        self.contentLable.text = item.getContent()
    }
    
}
