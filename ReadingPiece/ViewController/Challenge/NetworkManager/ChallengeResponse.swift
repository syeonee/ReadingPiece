import Foundation

public struct ChallengeResponse: Codable {
    public let isSuccess: Bool
    public let code: Int
    public let message: String
    public let getchallenge1Rows: [Challenge]?
    public let getchallenge2Rows: [ReadingGoal]?
    public let getchallenge3Rows: TodayGoal?
}

public struct TodayReadingResponse: Codable {
    public let isSuccess: Bool
    public let code: Int
    public let message: String
    public let getcontinuityRows: [ReadingContinuity]?
    public let getcontinuity2Rows: [TodayReadingStatus]?
}

public struct ReadingBookTimeResponse: Codable {
    public let isSuccess: Bool
    public let code: Int
    public let message: String
    public let result: ReadingBookTime?
}

public struct ReadingBookTime: Codable {
    public let goalId: Int
    public let userId: Int
    public let title: String
    public let sumtime: String // 오늘 책 읽은 시간 합계
}
