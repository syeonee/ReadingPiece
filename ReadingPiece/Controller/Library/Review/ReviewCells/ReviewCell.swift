//
//  ReviewCell.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/04.
//

import UIKit

class ReviewCell: UITableViewCell {
    
    let cellID = "ReviewCell"
    var moreDelegate: ReviewMoreDelegate?
    var editDelegate: ReviewEditDelegate?
    var likeDelegate: ReviewLikeDelegate?
    var commentsDelegate: ReviewCommentsDelegate?
    
    var likeState: Bool = false
    
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var ratingView: UIView!
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var reviewTextLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var commentCount: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        upperView.layer.cornerRadius = 4
        bookImageView.layer.cornerRadius = 4
        ratingView.layer.cornerRadius = 5
        ratingView.layer.borderWidth = 0.3
        ratingView.layer.borderColor = UIColor.melon.cgColor
        ratingLabel.textColor = .melon
        reviewTextLabel.lineBreakMode = .byWordWrapping
    }
    
    @IBAction func moreButtonTapped(_ sender: UIButton) {
        moreDelegate?.didTapMoreButton(cell: self)
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        editDelegate?.didTapEditButton(cell: self)
    }
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        if likeState == false {
            likeDelegate?.didTapLikeButton(cell: self)
            //self.likeButton.setImage(UIImage(named: "like icon"), for: .normal)
            self.likeButton.setImage(UIImage(named: "like icon_fill"), for: .normal)
            self.likeState = true
        } else {
            likeDelegate?.deselectLikeButton(cell: self)
            //self.likeButton.setImage(UIImage(named: "like icon_fill"), for: .normal)
            self.likeButton.setImage(UIImage(named: "like icon"), for: .normal)
            self.likeState = false
        }
    }
    @IBAction func commentsButtonTapped(_ sender: Any) {
        commentsDelegate?.didTapCommentButton()
    }
    
    
    
}

protocol ReviewMoreDelegate {
    func didTapMoreButton(cell: ReviewCell)
}
protocol ReviewEditDelegate {
    func didTapEditButton(cell: ReviewCell)
}
protocol ReviewLikeDelegate {
    func didTapLikeButton(cell: ReviewCell)
    func deselectLikeButton(cell: ReviewCell)
}
protocol ReviewCommentsDelegate {
    func didTapCommentButton()
}
