//
//  Piece.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/03/24.
//

import Foundation

public struct Piece: Codable {
    public let goalId: Int
    public let isComplete: String
    public let cake: String
    public let challengeName: String
    public let challengePeriod: String
    public let wholeCake: String
}
