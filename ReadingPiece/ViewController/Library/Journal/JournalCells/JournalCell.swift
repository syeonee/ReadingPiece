//
//  JournalCell.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/05.
//

import UIKit

class JournalCell: UITableViewCell {
    
    let cellID = "JournalCell"
    var moreDelegate: JournalMoreDelegate?
    var editDelegate: JournalEditDelegate?
    var index: Int?
    
    @IBOutlet weak var mainBackgoundView: UIView!
    @IBOutlet weak var firstContainerView: UIView!
    @IBOutlet weak var secondContainerView: UIView!
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var journalTextLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var readingPercentLabel: UILabel!
    
    @IBOutlet weak var readingTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = .lightgrey2
        
        self.mainBackgoundView.layer.shadowColor = UIColor.black.cgColor
        self.mainBackgoundView.layer.shadowOpacity = 0.15
        self.mainBackgoundView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        self.mainBackgoundView.layer.cornerRadius = 8
        
        self.firstContainerView.layer.cornerRadius = 5
        self.secondContainerView.layer.cornerRadius = 5
    }

    @IBAction func moreButtonTapped(_ sender: Any) {
        guard let idx = index else {return}
        moreDelegate?.didTapMoreButton(index: idx)
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        guard let idx = index else {return}
        editDelegate?.didTapEditButton(index: idx)
    }
    
}

protocol JournalMoreDelegate {
    func didTapMoreButton(index: Int)
}
protocol JournalEditDelegate {
    func didTapEditButton(index: Int)
}
