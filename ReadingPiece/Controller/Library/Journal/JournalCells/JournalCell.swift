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
        moreDelegate?.didTapMoreButton(cell: self)
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        editDelegate?.didTapEditButton(cell: self)
    }
    
}

protocol JournalMoreDelegate {
    func didTapMoreButton(cell: JournalCell)
}
protocol JournalEditDelegate {
    func didTapEditButton(cell: JournalCell)
}
