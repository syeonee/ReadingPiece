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
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
