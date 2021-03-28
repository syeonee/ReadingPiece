import Foundation

public struct BookResponse: Codable {
    public let isSuccess: Bool?
    public let code: Int?
    public let message: String?
}
