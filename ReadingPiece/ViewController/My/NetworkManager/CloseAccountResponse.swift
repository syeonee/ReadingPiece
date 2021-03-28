//
//  CloseAccountResponse.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/28.
//

import Foundation

public struct CloseAccountResponse: Codable {
    public let isSuccess: Bool
    public let code: Int
    public let message: String
    
    enum CodingKeys: String, CodingKey {
        case isSuccess
        case code
        case message
    }
}
