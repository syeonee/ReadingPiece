//
//  JoinResponse.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/18.
//

import Foundation

public struct JoinResponse: Codable {
    public let isSuccess: Bool
    public let code: Int
    public let message: String
}


