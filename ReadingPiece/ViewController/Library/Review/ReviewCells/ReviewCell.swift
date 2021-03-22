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
    
    var index: Int?
    var likeState: Bool = false {
        didSet {
            if likeState == true {
                likeButton.setImage(UIImage(named: "like icon_fill"), for: .normal)
            } else {
                likeButton.setImage(UIImage(named: "like icon"), for: .normal)
            }
        }
    }
    
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
        guard let idx = index else {return}
        moreDelegate?.didTapMoreButton(index: idx)
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        guard let idx = index else {return}
        editDelegate?.didTapEditButton(index: idx)
    }
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        guard let idx = index else {return}
        if likeState == false {
            likeButton.setImage(UIImage(named: "like icon_fill"), for: .normal)
            likeDelegate?.didTapLikeButton(index: idx, like: true)
            likeState = true
        } else {
            likeButton.setImage(UIImage(named: "like icon"), for: .normal)
            likeDelegate?.didTapLikeButton(index: idx, like: false)
            likeState = false
        }
    }
    @IBAction func commentsButtonTapped(_ sender: Any) {
        commentsDelegate?.didTapCommentButton()
    }
    
    
    
}

protocol ReviewMoreDelegate {
    func didTapMoreButton(index: Int)
}
protocol ReviewEditDelegate {
    func didTapEditButton(index: Int)
}
protocol ReviewLikeDelegate {
    func didTapLikeButton(index: Int, like: Bool)
}
protocol ReviewCommentsDelegate {
    func didTapCommentButton()
}
