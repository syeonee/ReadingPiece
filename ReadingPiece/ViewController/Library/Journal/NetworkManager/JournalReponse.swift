//
//  GetJournalResponse.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/23.
//

import Foundation

// 일지 GET, PATCH, Response

struct GetJournalResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [GetJournalResponseResult]?
}

struct GetJournalResponseResult: Codable {
    let title, text, postAt: String
        let percent, time, page, bookID: Int
        let journalID: Int

        enum CodingKeys: String, CodingKey {
            case title, text, postAt, percent, time, page
            case bookID = "bookId"
            case journalID = "journalId"
        }
}

// 일지 DELETE Response

struct DeleteJournalResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
}

// 선택한 일지 이미지 GET

struct GetJournalImageResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [GetJournalImageResponseResult]
}

struct GetJournalImageResponseResult: Codable {
    let journalID: Int
    let text, journalImageURL, resultOpen: String
    let time, page, percent: Int
    let title, writer: String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case journalID = "journalId"
        case text, journalImageURL
        case resultOpen = "open"
        case time, page, percent, title, writer, imageURL
    }
}

