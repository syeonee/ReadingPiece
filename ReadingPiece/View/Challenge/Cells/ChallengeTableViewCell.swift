//
//  ChallengeTableViewCell.swift
//  ReadingPiece
//
//  Created by HanaHan on 2021/03/08.
//

import UIKit

class ChallengeTableViewCell: UITableViewCell {
    
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

    static var identifier: String = "ChallengeTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        challengeTitleButton.setTitleColor(.charcoal, for: .normal)
        todayRadingPage.textColor = .grey
        todayRadingTime.textColor = .grey
        totalDiary.textColor = .grey
        
        let daillyReadingPercentText = NSMutableAttributedString()
            .bold("00", fontSize: 28)
            .normal("%", fontSize: 18)
        daillyReadingStatusLabel.attributedText = daillyReadingPercentText
        let daillyReadingTimeText = NSMutableAttributedString()
            .bold("00", fontSize: 28)
            .normal("분", fontSize: 18)
        daillyReadingTimeLabel.attributedText = daillyReadingTimeText
        let totalDiaryCountText = NSMutableAttributedString()
            .bold("00", fontSize: 28)
            .normal("개", fontSize: 18)
        totalDiary.attributedText = totalDiaryCountText
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
