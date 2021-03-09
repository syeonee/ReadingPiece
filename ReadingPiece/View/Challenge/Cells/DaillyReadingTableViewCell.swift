//
//  DaillyReadingTableViewCell.swift
//  ReadingPiece
//
//  Created by HanaHan on 2021/03/08.
//

import UIKit

class DaillyReadingTableViewCell: UITableViewCell {
    static var identifier: String = "DaillyReadingTableViewCell"
    
    @IBOutlet weak var challengeStatusButton: UIButton!
    @IBOutlet weak var remainingDaysLabel: UILabel!
    @IBOutlet weak var challengeNameLabel: UILabel!
    @IBOutlet weak var challengeImage: UIImageView!
    @IBOutlet weak var challengeReaminingBooks: UILabel!
    @IBOutlet weak var challengeExpireDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
