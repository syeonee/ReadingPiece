//
//  Book.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/03/10.
//

import Foundation
import Alamofire

struct Book: Codable {
    let title: String
    let authors: [String]
    let publisher: String
    let thumbnailPath: String
    let summary: String

    enum CodingKeys: String, CodingKey {
        case title
        case authors
        case publisher
        case thumbnailPath = "thumbnail"
        case summary = "contents"
    }
}

struct Meta: Codable {
    let resultCount: Int
    let isEnd: Bool
    
    enum CodingKeys: String, CodingKey {
        case resultCount = "total_count"
        case isEnd = "is_end"
    }
}

struct Response: Codable {
    let books: [Book]
    let meta: Meta
    
    enum CodingKeys: String, CodingKey {
        case books = "documents"
        case meta
    }
}
