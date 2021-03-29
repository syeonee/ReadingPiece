//
//  FeedResponse.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/03/29.
//
import Foundation

public struct FeedResponse: Codable {
    public let isSuccess: Bool
    public let code: Int
    public let message: String
    public let feed: [Feed]?
    
    enum CodingKeys: String, CodingKey {
        case isSuccess
        case code
        case message
        case feed = "result"
    }
}
