//
//  Piece.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/03/24.
//

import Foundation

public struct Piece: Codable {
    public let name: String?
    public let resolution: String?
    public let profileImagePath: String?

    enum CodingKeys: String, CodingKey {
        case name
        case resolution = "vow"
        case profileImagePath = "profilePictureURL"
    }
}
