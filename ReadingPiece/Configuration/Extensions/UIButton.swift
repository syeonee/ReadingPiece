//
//  UIButton.swift
//  ReadingPiece
//
//  Created by HanaHan on 2021/03/11.
//

import Foundation
import UIKit

extension UIButton {
    func makeRoundedButtnon(_ title: String, titleColor: UIColor , borderColor: CGColor, backgroundColor: UIColor) {
        self.contentEdgeInsets = UIEdgeInsets(top: 11, left: 20, bottom: 15, right: 20)
        self.setTitleColor(titleColor, for: .normal)
        self.setTitle(title, for: .normal)
        self.layer.borderWidth = 1
        self.layer.borderColor = borderColor
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = self.frame.height / 2
    }

    func makeSmallRoundedButtnon(_ title: String, titleColor: UIColor , borderColor: CGColor, backgroundColor: UIColor) {
        self.contentEdgeInsets = UIEdgeInsets(top: 4, left: 12, bottom: 7, right: 12)
        self.setTitleColor(titleColor, for: .normal)
        self.setTitle(title, for: .normal)
        self.layer.borderWidth = 1
        self.layer.borderColor = borderColor
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = 16
    }
    
    func makeRoundedTagButtnon(_ title: String, titleColor: UIColor , borderColor: CGColor, backgroundColor: UIColor) {
        self.contentEdgeInsets = UIEdgeInsets(top: 1, left: 10, bottom: 3, right: 10)
        self.setTitleColor(titleColor, for: .normal)
        self.setTitle(title, for: .normal)
        self.layer.borderWidth = 1
        self.layer.borderColor = borderColor
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = 4
    }
}
