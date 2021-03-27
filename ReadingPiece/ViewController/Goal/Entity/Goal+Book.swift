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

public struct UserBookReview: Codable {
    public var title: String? // 책 제목
    public var imageURL: String? // 책 표지 이미지
    public var writer: String? // 작가
    public var publisher: String? // 출판사
    public var publishDate: String? // 출판일
    public var contents: String? // 줄거리
    public var reviewSum: Int // 해당 책에 작성된 리뷰 개수
    public var userId: Int?
    public var name: String? // 유저 이름
    public var profilePictureURL: String? // 유저 프사
    public var postAt: String? // 리뷰 작성일
    public var star: Int? // 평점
    public var reviewId: Int?
    public var text: String? // 리뷰 내용
    public var status: String? // 완독유무 : Y or N
}

public struct UserReviewCount: Codable {
    public var currentRead: Int
}


