import Foundation

public struct PostReadingGoalResponse: Codable {
    public let isSuccess: Bool?
    public let code: Int?
    public let message: String?
    public let goalId: Int?
}

public struct PatchReadingGoalResponse: Codable {
    public let isSuccess: Bool?
    public let code: Int?
    public let message: String?
}
