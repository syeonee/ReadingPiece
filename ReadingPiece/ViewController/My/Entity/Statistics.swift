//
//  Statistics.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/03/28.
//

import Foundation

public struct ContinuityDay: Codable {
    public let goalId: Int
    public let startDay: String
    public let totalReadingDay: Int

    enum CodingKeys: String, CodingKey {
        case goalId
        case startDay = "createAt"
        case totalReadingDay = "countDay"
    }
}

public struct ReadingInfo: Codable {
    public let userId: Int
    public let resolution: String?
    public let profileImage: String?
    public let name: String
    public let totalReadingTime: String
    public let totalBookQuantity: Int

    enum CodingKeys: String, CodingKey {
        case userId
        case resolution = "vow"
        case profileImage = "profilePictureURL"
        case name
        case totalReadingTime = "sumTime"
        case totalBookQuantity = "countBook"
    }
}

public struct MonthReadingInfo: Codable {
    public let date: Int
    public let sum: String

    enum CodingKeys: String, CodingKey {
        case date
        case sum = "sum(time)"
    }
}
