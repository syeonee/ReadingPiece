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
    @IBOutlet weak var underlineView: UIView!
    
    override public var isSelected: Bool {
        didSet {
            if isSelected {
                titleLabel.textColor = .melon
                titleLabel.font = .NotoSans(.bold, size: 16)
            } else {
                titleLabel.textColor = .darkgrey
                titleLabel.font = .NotoSans(.regular, size: 16)
                underlineView.backgroundColor = #colorLiteral(red: 0.7097821832, green: 0.7097831368, blue: 0.7140277028, alpha: 1)
            }
        }
    }
    
}

