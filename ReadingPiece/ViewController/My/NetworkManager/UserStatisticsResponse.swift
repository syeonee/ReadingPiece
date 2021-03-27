//
//  UserStatisticsResponse.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/03/28.
//

import Foundation

public struct UserStatisticsResponse: Codable {
    public let isSuccess: Bool
    public let code: Int
    public let message: String
    public let continuityDay: ContinuityDay
    public let readingInfo: ReadingInfo
    
    enum CodingKeys: String, CodingKey {
        case isSuccess
        case code
        case message
        case continuityDay = "getcontinuityRows"
        case readingInfo = "getReadingInfoRows"
    }
}
