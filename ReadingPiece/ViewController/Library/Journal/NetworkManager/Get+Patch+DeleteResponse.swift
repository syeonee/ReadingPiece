//
//  GetJournalResponse.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/23.
//

import Foundation

// 일지 GET, PATCH, DELETE Response

struct GetJournalResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [GetJournalResponseResult]?
}

// MARK: - Result
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
