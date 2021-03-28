//
//  Goal.swift
//  ReadingPiece
//
//  Created by HanaHan on 2021/03/20.
//

import Foundation

// 목표 설정에 필요한 구조체
struct Goal {
    var period: String
    var amount: Int
    var time: Int
}

// 일반 책 추가에 필요한 구조체(챌린지 중인 책과 다름)
struct GeneralBook {
    var writer: String // 저자
    var publishDate: String // 출판일
    var publishNumber: String // isbn
    var contents: String // 줄거리
    var imageURL: String // 표지 이미지
    var title: String // 제목
    var publisher: String // 출판사
}



