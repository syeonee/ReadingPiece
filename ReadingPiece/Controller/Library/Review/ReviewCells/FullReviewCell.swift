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

    @IBOutlet weak var reviewTextLabel: UILabel!
    
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var ratingView: UIView!
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        upperView.layer.cornerRadius = 4
        bookImageView.layer.cornerRadius = 4
        ratingView.layer.cornerRadius = 5
        ratingView.layer.borderWidth = 0.3
        ratingView.layer.borderColor = UIColor.melon.cgColor
        ratingLabel.textColor = .melon
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        editDelegate?.didTapFullEditButton(cell: self)
    }
    
    
}

protocol ReviewFullEditDelegate {
    func didTapFullEditButton(cell: FullReviewCell)
}
