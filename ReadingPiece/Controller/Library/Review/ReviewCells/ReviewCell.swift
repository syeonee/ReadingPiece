//
//  ReviewCell.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/04.
//

import UIKit

class ReviewCell: UITableViewCell {
    
    let cellID = "ReviewCell"

    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var ratingView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        upperView.layer.cornerRadius = 4
        bookImageView.layer.cornerRadius = 4
        ratingView.layer.cornerRadius = 5
        ratingView.layer.borderWidth = 0.3
        ratingView.layer.borderColor = #colorLiteral(red: 1, green: 0.4199270606, blue: 0.3739868402, alpha: 1)
    }

    
    
}
