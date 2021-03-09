//
//  ChallengeTableViewCell.swift
//  ReadingPiece
//
//  Created by HanaHan on 2021/03/08.
//

import UIKit

class ChallengeTableViewCell: UITableViewCell {
    static var identifier: String = "ChallengeTableViewCell"
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var challengeTitleButton: UIButton!
    @IBOutlet weak var daillyReadingStatusLabel: UILabel!
    @IBOutlet weak var daillyReadingTimeLabel: UILabel!
    @IBOutlet weak var totalDiaryCountLabel: UILabel!
    
    // 로직 적용 없이, UI설정만 필요한 아웃렛들
    @IBOutlet weak var cellTitleLabel: UILabel!
    @IBOutlet weak var todayRadingPage: UILabel!
    @IBOutlet weak var todayRadingTime: UILabel!
    @IBOutlet weak var totalDiary: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
