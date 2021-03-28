//
//  ReviewBookInfoCell.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/11.
//

import UIKit

class ReviewBookInfoCell: UITableViewCell {
    
    let cellID = "ReviewBookInfoCell"
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var authorTitleLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var publisherTitleLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        titleLabel.textColor = .charcoal
        authorLabel.textColor = .charcoal
        authorTitleLabel.textColor = .middlegrey1
        publisherLabel.textColor = .charcoal
        publisherTitleLabel.textColor = .middlegrey1
    }
    
}
