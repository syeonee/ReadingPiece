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
    var likeDelegate: ReviewFullLikeDelegate?
    var commentsDelegate: ReviewFullCommentsDelegate?
    
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

    @IBOutlet weak var reviewTextLabel: UILabel!
    
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var ratingView: UIView!
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
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
        
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        guard let idx = index else {return}
        editDelegate?.didTapFullEditButton(index: idx)
    }
    
    @IBAction func likeButtonTapped(_ sender: Any) {
        guard let idx = index else {return}
        if likeState == false {
            self.likeButton.setImage(UIImage(named: "like icon_fill"), for: .normal)
            likeDelegate?.didTapFullLikeButton(index: idx, like: true)
            self.likeState = true
        } else {
            self.likeButton.setImage(UIImage(named: "like icon"), for: .normal)
            likeDelegate?.didTapFullLikeButton(index: idx, like: false)
            self.likeState = false
        }
    }
    @IBAction func commentsButtonTapped(_ sender: Any) {
        commentsDelegate?.didTapFullCommentButton()
    }
    
    
}

protocol ReviewFullEditDelegate {
    func didTapFullEditButton(index: Int)
}
protocol ReviewFullLikeDelegate {
    func didTapFullLikeButton(index: Int, like: Bool)
}
protocol ReviewFullCommentsDelegate {
    func didTapFullCommentButton()
}
