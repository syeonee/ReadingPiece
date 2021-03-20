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
    
    override public var isSelected: Bool {
        didSet {
            if isSelected {
                menuLabel.textColor = .melon
                if let textString = menuLabel.text {
                    let attributedString = NSMutableAttributedString(string: textString)
                    attributedString.addAttribute(NSAttributedString.Key.underlineStyle,
                                                  value: NSUnderlineStyle.single.rawValue,
                                                  range: NSRange(location: 0, length: attributedString.length))
                    menuLabel.attributedText = attributedString
                }
            } else {
                menuLabel.textColor = .darkgrey
                if let textString = menuLabel.text {
                    menuLabel.attributedText = nil
                    menuLabel.text = textString
                }
            }
        }
    }
}
