import Foundation

public struct SignUpResponse: Codable {
    public let isSuccess: Bool?
    public let code: Int?
    public let message: String?

}
