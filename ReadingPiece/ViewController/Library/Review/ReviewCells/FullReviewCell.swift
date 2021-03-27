//
//  FullReviewCell.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/05.
//

import UIKit

class FullReviewCell: UITableViewCell {
    
    let cellID = "FullReviewCell"
    var editDelegate: ReviewFullEditDelegate?
    
    var index: Int?

    @IBOutlet weak var reviewTextLabel: UILabel!
    
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var ratingView: UIView!
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var isCompletedLabel: UILabel!
    @IBOutlet weak var timeImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var isPublicLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        upperView.layer.cornerRadius = 4
        bookImageView.layer.cornerRadius = 4
        ratingView.layer.cornerRadius = 5
        ratingView.layer.borderWidth = 0.3
        ratingView.layer.borderColor = UIColor.melon.cgColor
        ratingLabel.textColor = .melon
        isPublicLabel.font = .NotoSans(.regular, size: 12)
        isPublicLabel.textColor = .grey
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        guard let idx = index else {return}
        editDelegate?.didTapFullEditButton(index: idx)
    }
    
    
}

protocol ReviewFullEditDelegate {
    func didTapFullEditButton(index: Int)
}
