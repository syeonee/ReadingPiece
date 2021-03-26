import Foundation

public struct ChallengeResponse: Codable {
    public let isSuccess: Bool
    public let code: Int
    public let message: String
    public let getchallenge1Rows: [ReadingBook]? // 읽고있는 책 정보
    public let getchallenge2Rows: [ReadingGoal]? // 읽고있는 책별 읽기 현황
    public let getchallenge3Rows: [Challenge]? // 전체 챌린지 진행상황
    public let isExpired: Bool? // 챌린지 만료 여부 
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
