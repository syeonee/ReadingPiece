//
//  MyMenuCell.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/03/20.
//

import UIKit
import PagingKit

class MyMenuCell: PagingMenuViewCell {
    
    @IBOutlet weak var menuLabel: UILabel!
    @IBOutlet weak var underBarView: UIView!
    
    
    override public var isSelected: Bool {
        didSet {
            if isSelected {
                menuLabel.textColor = .melon
                underBarView.isHidden = false
            } else {
                menuLabel.textColor = .darkgrey
                underBarView.isHidden = true
            }
        }
    }
}
