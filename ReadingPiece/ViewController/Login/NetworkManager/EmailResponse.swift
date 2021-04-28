//
//  EmailResponse.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/31.
//

import Foundation

// 이메일 api 응답구조
public struct EmailResponse: Codable {
    public let isSuccess: Bool
    public let code: Int
    public let message: String
}
