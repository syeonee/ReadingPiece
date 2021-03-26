//
//  ReviewTableViewCell.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/03/08.
//

import UIKit
import Kingfisher

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var bookImageView: UIImageView!
    
    @IBOutlet weak var star1ImageView: UIImageView!
    @IBOutlet weak var star2ImageView: UIImageView!
    @IBOutlet weak var star3ImageView: UIImageView!
    @IBOutlet weak var star4ImageView: UIImageView!
    @IBOutlet weak var star5ImageView: UIImageView!
    @IBOutlet weak var isCompletedImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var moreReadButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    
    var reviewCellDelegate : ReviewTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        bookImageView.layer.cornerRadius = bookImageView.frame.height/2
        bookImageView.clipsToBounds = true
        drawStars(rating: 3)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupUI() {
        likeButton.isHidden = true
        commentButton.isHidden = true
        isCompletedImage.isHidden = true
    }
    
    func configure(reviewData: UserBookReview) {
        let stars = [star1ImageView, star2ImageView, star3ImageView, star4ImageView, star5ImageView]

        nameLabel.text = reviewData.name
        dateLabel.text = reviewData.postAt
        reviewLabel.text = reviewData.contents
        let imgUrl = URL(string: reviewData.imageURL!)
        bookImageView.kf.setImage(with: imgUrl)
        
//        // 리뷰 별점에 따른 별 이미지 적용
//        var looper = reviewData.star!
//        while looper < stars.count {
//            stars[looper]?.image = UIImage(named: "selectedStar")
//            looper += 1
//        }
    }
    
    @IBAction func textExpandButtonTapped(_ sender: Any) {
        reviewCellDelegate?.moreTextButtonTapped(cell: self)
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        reviewCellDelegate?.editReviewButtonTapped(cell: self)
    }
    @IBAction func likeButtonTapped(_ sender: Any) {
        reviewCellDelegate?.likeButtonTapped(cell: self)
    }

    @IBAction func commentButtonTapped(_ sender: Any) {
        reviewCellDelegate?.commentButtonTapped(cell: self)
    }
    
    func drawStars(rating: Int) {
        let stars = [star1ImageView,star2ImageView,star3ImageView,star4ImageView,star5ImageView]
        stars.enumerated().forEach{ (index,star) in
            if rating < (index+1) {
                star?.isHidden = true
            }
        }
    }
    
}

protocol ReviewTableViewCellDelegate {
    func moreTextButtonTapped(cell: ReviewTableViewCell)
    func editReviewButtonTapped(cell: ReviewTableViewCell)
    func likeButtonTapped(cell: ReviewTableViewCell)
    func commentButtonTapped(cell: ReviewTableViewCell)
}
