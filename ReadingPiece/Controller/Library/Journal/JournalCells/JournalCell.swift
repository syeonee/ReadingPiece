//
//  JournalCell.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/05.
//

import UIKit

class JournalCell: UITableViewCell {
    
    let cellID = "JournalCell"
    
    @IBOutlet weak var mainBackgoundView: UIView!
    @IBOutlet weak var firstContainerView: UIView!
    @IBOutlet weak var secondContainerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.mainBackgoundView.layer.shadowColor = UIColor.black.cgColor
        self.mainBackgoundView.layer.shadowOpacity = 0.15
        self.mainBackgoundView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        self.mainBackgoundView.layer.cornerRadius = 8
        
        self.firstContainerView.layer.cornerRadius = 5
        self.secondContainerView.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
