import Foundation

public struct ChallengeResponse: Codable {
    public let isSuccess: Bool
    public let code: Int
    public let message: String
    public let readingBooks: [ReadingBook]? // 읽고있는 책 정보
    public let goalStatus: [ReadingGoal]? // 읽고있는 책별 읽기 현황
    public let challenge: [Challenge]? // 전체 챌린지 진행상황
    public let isExpired: Bool // 챌린지 만료 여부
    
    enum CodingKeys: String, CodingKey {
        case isSuccess
        case code
        case message
        case readingBooks = "getchallenge1Rows"
        case goalStatus = "getchallenge2Rows"
        case challenge = "getchallenge3Rows"
        case isExpired
    }
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
    public let goalId: Int?
    public let userId: Int?
    public let title: String?
    public let sumtime: String? // 오늘 책 읽은 시간 합계
}

public struct AllReadingBookResponse: Codable {
    public let isSuccess: Bool
    public let code: Int
    public let message: String
    public let getbookListRows: [AllReadingBook]?
}

public struct AllReadingBook: Codable {
    public let title : String // 제목
    public let imageURL: String // 책 썸네일
    public let writer: String // 저자
    public let goalBookId: Int
    public let reading: String // 현재 도전중 여부
}

public struct DeleteChallengeResponse: Codable {
    public let isSuccess: Bool
    public let code: Int
    public let message: String
}
