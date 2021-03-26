//
//  UserProfileResponse.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/03/23.
//

import Foundation

public struct UserProfileResponse: Codable {
    public let isSuccess: Bool
    public let code: Int
    public let message: String
    public let profile: Profile?
    
    enum CodingKeys: String, CodingKey {
        case isSuccess
        case code
        case message
        case profile = "results"
    }
}
