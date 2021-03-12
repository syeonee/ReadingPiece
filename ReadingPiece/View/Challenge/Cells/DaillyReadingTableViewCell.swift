//
//  DaillyReadingTableViewCell.swift
//  ReadingPiece
//
//  Created by HanaHan on 2021/03/08.
//

import UIKit

class DaillyReadingTableViewCell: UITableViewCell {
    static var identifier: String = "DaillyReadingTableViewCell"
    
    @IBOutlet weak var innerStatusBarWidth: NSLayoutConstraint!
    @IBOutlet weak var innerChallengeStatusBar: UIView!
    @IBOutlet weak var outerChallengeStatusBar: UIView!
    @IBOutlet weak var challengeStatusButton: UIButton!
    @IBOutlet weak var remainingDaysLabel: UILabel!
    @IBOutlet weak var challengeNameLabel: UILabel!
    @IBOutlet weak var challengeImage: UIImageView!
    @IBOutlet weak var challengeReaminingBooks: UILabel!
    @IBOutlet weak var challengeExpireDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        challengeStatusButton.makeSmallRoundedButtnon("진행 중", titleColor: .main, borderColor: UIColor.main.cgColor, backgroundColor: .white)
        remainingDaysLabel.textColor = .darkgrey
        challengeExpireDate.textColor = .darkgrey
        challengeReaminingBooks.textColor = .darkgrey
        innerChallengeStatusBar.layer.cornerRadius = 5
        outerChallengeStatusBar.layer.cornerRadius = 5
        outerChallengeStatusBar.layer.borderWidth = 1
        outerChallengeStatusBar.layer.borderColor = UIColor.black.cgColor
        outerChallengeStatusBar.backgroundColor = .white
        innerChallengeStatusBar.backgroundColor = .main
    }
    
    func setSatustBarGage(readingPercent: CGFloat) {
        innerStatusBarWidth.constant = outerChallengeStatusBar.layer.bounds.width * readingPercent
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
