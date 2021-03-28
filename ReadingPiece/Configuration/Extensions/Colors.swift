//
//  Colors.swift
//  ReadingPiece
//
//  Created by HanaHan on 2021/03/02.
//

import UIKit

extension UIColor {

    @nonobjc class var tableViewBackroundGray: UIColor {
        return UIColor(red: 229.0 / 255.0, green: 229.0 / 255.0, blue: 229.0 / 255.0, alpha: 1.0)
    }

  @nonobjc class var lightgrey2: UIColor {
    return UIColor(white: 246.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var main: UIColor {
    return UIColor(red: 1.0, green: 108.0 / 255.0, blue: 95.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var lightgrey1: UIColor {
    return UIColor(white: 242.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var middlegrey2: UIColor {
    return UIColor(white: 218.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var black: UIColor {
    return UIColor(white: 0.0, alpha: 1.0)
  }

  @nonobjc class var darkgrey: UIColor {
    return UIColor(white: 128.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var middlegrey1: UIColor {
    return UIColor(white: 181.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var white: UIColor {
    return UIColor(white: 1.0, alpha: 1.0)
  }

  @nonobjc class var charcoal: UIColor {
    return UIColor(white: 101.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var sub2: UIColor {
    return UIColor(red: 1.0, green: 178.0 / 255.0, blue: 171.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var sub1: UIColor {
    return UIColor(red: 1.0, green: 135.0 / 255.0, blue: 123.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var hover: UIColor {
    return UIColor(red: 235.0 / 255.0, green: 88.0 / 255.0, blue: 75.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var coral: UIColor {
    return UIColor(red: 253.0 / 255.0, green: 111.0 / 255.0, blue: 113.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var yellowSub: UIColor {
    return UIColor(red: 1.0, green: 221.0 / 255.0, blue: 44.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var mintPoint: UIColor {
    return UIColor(red: 69.0 / 255.0, green: 1.0, blue: 152.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var yellowSub2: UIColor {
    return UIColor(red: 1.0, green: 235.0 / 255.0, blue: 105.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var clock: UIColor {
    return UIColor(red: 171.0 / 255.0, green: 105.0 / 255.0, blue: 1.0, alpha: 1.0)
  }

  @nonobjc class var grey: UIColor {
    return UIColor(white: 171.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var fillDisabled: UIColor {
    return UIColor(red: 244.0 / 255.0, green: 244.0 / 255.0, blue: 245.0 / 255.0, alpha: 1.0)
  }
    
    @nonobjc class var disabled2: UIColor {
      return UIColor(red: 1.0, green: 21.0 / 255.0, blue: 0.0, alpha: 1.0)
    }
    
    @nonobjc class var melon: UIColor {
      return UIColor(red: 1.0, green: 108.0 / 255.0, blue: 95.0 / 255.0, alpha: 1.0)
    }

}

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
