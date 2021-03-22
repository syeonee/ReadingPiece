//
//  NSMutableAttributedString.swift
//  ReadingPiece
//
//  Created by HanaHan on 2021/03/12.
//

import UIKit

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

