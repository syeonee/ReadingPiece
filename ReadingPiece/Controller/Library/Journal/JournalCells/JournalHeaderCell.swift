//
//  JournalHeaderCell.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/05.
//

import UIKit

class JournalHeaderCell: UITableViewHeaderFooterView {
    
    let identifier = "JournalHeaderCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = .lightgrey2
    }
    
}
