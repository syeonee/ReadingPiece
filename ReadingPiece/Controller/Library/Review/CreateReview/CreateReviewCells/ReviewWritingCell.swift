//
//  ReviewWritingCell.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/11.
//

import UIKit

class ReviewWritingCell: UITableViewCell {
    
    let cellID = "ReviewWritingCell"

    @IBOutlet weak var reviewInputTextView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        reviewInputTextView.backgroundColor = .lightgrey1
        reviewInputTextView.textColor = .middlegrey1
        reviewInputTextView.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
