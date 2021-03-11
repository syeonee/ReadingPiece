//
//  UIFont.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/07.
//

import Foundation
import UIKit

extension UIFont {
    public enum NotoSansType: String {
        case black = "Black"
        case bold = "Bold"
        case demiLight = "DemiLight"
        case light = "Light"
        case medium = "Medium"
        case regular = "Regular"
        case thin = "Thin"
    }

    static func NotoSans(_ type: NotoSansType, size: CGFloat) -> UIFont {
        return UIFont(name: "NotoSansCJKkr-\(type.rawValue)", size: size)!
    }
    
    // ex. label.font = .NotoSans(.medium, size: 16)
}

extension NSMutableAttributedString {
    func bold(_ text: String, fontSize: CGFloat) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.NotoSans(.bold, size: fontSize)]
        self.append(NSMutableAttributedString(string: text, attributes: attrs))
        return self
    }

    func normal(_ text: String, fontSize: CGFloat) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.NotoSans(.regular, size: fontSize)]
        self.append(NSMutableAttributedString(string: text, attributes: attrs))
        return self
    }

}
