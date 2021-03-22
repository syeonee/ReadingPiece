//
//  FullJournalCell.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/09.
//

import UIKit

class FullJournalCell: UITableViewCell {
    
    let cellID = "FullJournalCell"
    var editDelegate: FullJournalEditDelegate?

    @IBOutlet weak var mainBackgroundView: UIView!
    @IBOutlet weak var firstContainerView: UIView!
    @IBOutlet weak var secondContainerView: UIView!
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var journalTextLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var readingPercentageLabel: UILabel!
    @IBOutlet weak var readingTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = .lightgrey2
        
        self.mainBackgroundView.layer.shadowColor = UIColor.black.cgColor
        self.mainBackgroundView.layer.shadowOpacity = 0.15
        self.mainBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        self.mainBackgroundView.layer.cornerRadius = 8
        
        self.firstContainerView.layer.cornerRadius = 5
        self.secondContainerView.layer.cornerRadius = 5
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        editDelegate?.didTapFullEditButton(cell: self)
    }
    
}
protocol FullJournalEditDelegate {
    func didTapFullEditButton(cell: FullJournalCell)
}
