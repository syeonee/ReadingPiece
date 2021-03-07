//
//  Colors.swift
//  ReadingPiece
//
//  Created by HanaHan on 2021/03/02.
//

import UIKit

extension UIColor {
    // MARK: hex code를 이용하여 정의
    // ex. UIColor(hex: 0xF5663F)
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    // MARK: 메인 테마 색 또는 자주 쓰는 색을 정의
    // ex. label.textColor = .mainOrange
    class var stopWatchNumberBlack: UIColor { UIColor(hex: 0x656565) }
    class var stopWatchBackgroundPink: UIColor { UIColor(hex: 0xFFB2AB)}
    class var navigationBarButtonTitleColor: UIColor { UIColor(hex: 0xFF6C5F)}
    class var mainPink: UIColor { UIColor(hex: 0xFF6C5F)}
    class var subtitleGray: UIColor { UIColor(hex: 0x808080)}


}

extension CGColor {
    class var deepRed: CGColor { CGColor(red: 218, green: 37, blue: 123, alpha: 0)}
    class var rightOrange: CGColor { CGColor(red: 231, green: 92, blue: 91, alpha: 0)}

}

