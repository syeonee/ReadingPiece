//
//  MyPieceResponse.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/03/25.
//

import Foundation

public struct MyPieceResponse: Codable {
    public let isSuccess: Bool
    public let code: Int
    public let message: String
    public let pieces: [Piece]
    
    enum CodingKeys: String, CodingKey {
        case isSuccess
        case code
        case message
        case pieces = "results"
    }
}
