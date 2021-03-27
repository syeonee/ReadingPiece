//
//  ReviewRatingCell.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/11.
//

import UIKit
import Cosmos

class ReviewRatingCell: UITableViewCell {
    
    let cellID = "ReviewRatingCell"
    var starCount: Double = 0 {
        didSet {
            starRatingView.rating = starCount
        }
    }
    var delegate: ReviewRatingCellDelegate?

    @IBOutlet weak var starRatingView: CosmosView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupStar()
    }
    
    private func setupStar() {
        starRatingView.rating = 0
        starRatingView.settings.minTouchRating = 0
        starRatingView.settings.fillMode = .full
        starRatingView.settings.filledImage = UIImage(named: "selectedStar")
        starRatingView.settings.emptyImage = UIImage(named: "star")
        starRatingView.didFinishTouchingCosmos = { rating in
            print("result: \(rating)")
            self.starCount = rating
            self.delegate?.getRatingData(star: rating)
        }
    }
    
}
protocol ReviewRatingCellDelegate {
    func getRatingData(star: Double)
}
