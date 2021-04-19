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
    
    // 퍼센트에 따라 이미지파일용 이름을 반환하는 클로저
    var imageNameByChallengePercent: Int {
        var result = 0
        if self != 0 && self <= 20 {
            result = 20
        } else if 20 < self && self <= 40 {
            result = 40
        } else if 40 < self && self <= 60 {
            result = 60
        } else if 60 < self && self <= 80 {
            result = 80
        } else if 80 < self && self < 100 {
            result = 80
        } else if self == 100 {
            result = 100
        }
        return result
    }

}
