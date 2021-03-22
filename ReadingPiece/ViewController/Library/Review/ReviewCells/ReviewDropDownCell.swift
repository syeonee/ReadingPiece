//
//  ReviewDropDownCell.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/08.
//

import UIKit
import DropDown

class ReviewDropDownCell: DropDownCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.frame.size.height = 32
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
