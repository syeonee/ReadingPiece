//
//  ReadingBookTableViewCell.swift
//  ReadingPiece
//
//  Created by HanaHan on 2021/03/25.
//

import UIKit

class ReadingBookTableViewCell: UITableViewCell {
    static var identifier: String = "ReadingBookTableViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var isReadingNotifyButton: UIButton!
    @IBOutlet weak var readingBookStatusView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupUI() {
        titleLabel.textColor = .charcoal
        authorLabel.textColor = .darkgrey
        isReadingNotifyButton.makeSmallRoundedButtnon("도전 중", titleColor: .main, borderColor: UIColor.main.cgColor, backgroundColor: .white)
        readingBookStatusView.backgroundColor = .none
    }
    
    // 책 정보 cell에 입히는 함수
    func configure() {
    }
    
}
