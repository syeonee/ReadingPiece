import Foundation

public struct BookResponse: Codable {
    public let isSuccess: Bool?
    public let code: Int?
    public let message: String?
}


//public struct BookReviewResponse: Codable {
//    public let isSuccess: Bool?
//    public let code: Int?
//    public let message: String?
//    public let ReviewlikeCount: Int?
//    public let ReviewcommentCount: Int?
//}
