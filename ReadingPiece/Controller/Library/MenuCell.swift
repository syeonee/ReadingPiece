//
//  MenuCell.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/04.
//

import UIKit
import PagingKit

class MenuCell: PagingMenuViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    override public var isSelected: Bool {
        didSet {
            if isSelected {
                titleLabel.textColor = #colorLiteral(red: 1, green: 0.4199270606, blue: 0.3739868402, alpha: 1)
                //titleLabel.font = UIFont(name: <#T##String#>, size: <#T##CGFloat#>)
            } else {
                titleLabel.textColor = UIColor.systemGray
            }
        }
    }
}

