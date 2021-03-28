//
//  ReviewResponse.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/25.
//

import Foundation

// 리뷰 조회 api 응답구조
struct GetReviewResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let results: [GetReviewResult]?
}

struct GetReviewResult: Codable {
    let userID: Int
    let isCompleted: String
    let bookID: Int
    let title, writer, imageURL: String
    let reviewID, star: Int
    let text: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case isCompleted
        case bookID = "bookId"
        case title, writer, imageURL
        case reviewID = "reviewId"
        case star, text
    }
}
