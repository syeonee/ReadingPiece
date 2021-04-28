//
//  File.swift
//  ReadingPiece
//
//  Created by HanaHan on 2021/04/02.
//

import Foundation

extension Int {
    static func getMinutesTextByTime(_ time: Int) -> String {
        var text = ""
        if time > 60 {
            text = "\(time / 60)분"
        } else {
            text = "\(1)분"
        }
        return text
    }
}
