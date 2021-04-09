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
    @IBOutlet weak var totalJournalCountLabel: UILabel!
    
    // 로직 적용 없이, UI설정만 필요한 아웃렛들
    @IBOutlet weak var cellTitleLabel: UILabel!
    @IBOutlet weak var todayRadingPage: UILabel!
    @IBOutlet weak var todayRadingTime: UILabel!
    @IBOutlet weak var totalJournal: UILabel!

    static var identifier: String = "ChallengeTableViewCell"
    let userName = UserDefaults.standard.string(forKey: Constants.USERDEFAULT_KEY_GOAL_USER_NAME)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    // 서버에서 가져온 파싱결과를 바탕으로 화면에 일일 독서 결과를 반영
    func configure(readingContinuity: ReadingContinuity, todayReadingStatus: TodayReadingStatus) {
        let readingContinuanceDay = readingContinuity.continuanceDay ?? 0
        let readingPercent = todayReadingStatus.todayPercent ?? "0"
        let readingTime = todayReadingStatus.todayTime ?? "0"
        let writtenJournal = todayReadingStatus.sumjournal ?? 0
        let percentString = initNormalAndBoldLabel(boldText: readingPercent, normalText: "%")
        let readingTimeString = initNormalAndBoldLabel(boldText: readingTime, normalText: "분")
        let totalJournalString = initNormalAndBoldLabel(boldText: "\(writtenJournal)", normalText: "개")
        
        userNameLabel.text = "\(userName)님, 정말 부지런하시네요!"
        challengeTitleButton.setTitle("\(readingContinuanceDay)일 연속 독서", for: .normal)
        daillyReadingStatusLabel.attributedText = percentString
        daillyReadingTimeLabel.attributedText = readingTimeString
        totalJournalCountLabel.attributedText = totalJournalString
        
    }

    private func setupUI() {
        challengeTitleButton.setTitleColor(.charcoal, for: .normal)
        todayRadingPage.textColor = .grey
        todayRadingTime.textColor = .grey
        totalJournal.textColor = .grey
        
        let percentString = initNormalAndBoldLabel(boldText: "00", normalText: "%")
        let readingTimeString = initNormalAndBoldLabel(boldText: "00", normalText: "분")
        let totalJournalString = initNormalAndBoldLabel(boldText: "00", normalText: "개")
        
        daillyReadingStatusLabel.attributedText = percentString
        daillyReadingTimeLabel.attributedText = readingTimeString
        totalJournalCountLabel.attributedText = totalJournalString
    }
    
    private func initNormalAndBoldLabel(boldText: String, normalText: String) -> NSAttributedString {
        let text = NSMutableAttributedString()
            .bold(boldText, fontSize: 28)
            .normal(normalText, fontSize: 18)
        return text
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
