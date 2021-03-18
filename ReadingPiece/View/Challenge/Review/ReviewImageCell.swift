//
//  CollectionViewCell.swift
//  ReadingPiece
//
//  Created by HanaHan on 2021/03/18.
//

import UIKit

class ReviewImageCell: UICollectionViewCell {
    static var identifier: String = "ReviewImageCell"
    
    @IBOutlet weak var reviewImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func popReviewImage(_ sender: UIButton) {
        
    }
}
