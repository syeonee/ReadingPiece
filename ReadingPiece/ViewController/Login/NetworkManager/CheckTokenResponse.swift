//
//  CheckTokenResponse.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/25.
//

import Foundation

// 토큰 유효성 검사 응답구조

public struct CheckTokenResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let userID: Int
    let iat, exp: String

    enum CodingKeys: String, CodingKey {
        case isSuccess, code, message
        case userID = "userId"
        case iat, exp
    }
}
