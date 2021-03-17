//
//  UILabel.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/17.
//

import UIKit
extension UILabel {

func getTruncatingText(originalString: String, newEllipsis: String, maxLines: Int?) -> String {

    let maxLines = maxLines ?? self.numberOfLines

    guard maxLines > 0 else {
        return originalString
    }

    guard self.numberOfLinesNeeded(forString: originalString) > maxLines else {
        return originalString
    }

    var truncatedString = originalString

    var low = originalString.startIndex
    var high = originalString.endIndex
    // binary search substring
    while low != high {
        let mid = originalString.index(low, offsetBy: originalString.distance(from: low, to: high)/2)
        truncatedString = String(originalString[..<mid])
        if self.numberOfLinesNeeded(forString: truncatedString + newEllipsis) <= maxLines {
            low = originalString.index(after: mid)
        } else {
            high = mid
        }
    }

    // substring further to try and truncate at the end of a word
    var tempString = truncatedString
    var prevLastChar = "ㅠ"
    for _ in 0..<15 {
        if let lastChar = tempString.last {
            if (prevLastChar == " " && String(lastChar) != "") || prevLastChar == "." {
                truncatedString = tempString
                break
            }
            else {
                prevLastChar = String(lastChar)
                tempString = String(tempString.dropLast())
            }
        }
        else {
            break
        }
    }
    let lenForEllipsis = newEllipsis.utf8.count
    var whiteSpace = " "
    for _ in 0...lenForEllipsis {
        whiteSpace += " "
    }
    return truncatedString + whiteSpace
}

private func numberOfLinesNeeded(forString string: String) -> Int {
    let oneLineHeight = "각".size(withAttributes: [NSAttributedString.Key.font: font as Any]).height
    let totalHeight = self.getHeight(forString: string)
    let needed = Int(totalHeight / oneLineHeight)
    return needed
}

private func getHeight(forString string: String) -> CGFloat {
    return string.boundingRect(
        with: CGSize(width: self.bounds.size.width, height: CGFloat.greatestFiniteMagnitude),
        options: [.usesLineFragmentOrigin, .usesFontLeading],
        attributes: [NSAttributedString.Key.font: font as Any],
        context: nil).height
}
}
