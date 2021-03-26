//
//  Profile.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/03/23.
//

import Foundation

public struct Profile: Codable {
    public let name: String?
    public let resolution: String?
    public let profileImagePath: String?

    enum CodingKeys: String, CodingKey {
        case name
        case resolution = "vow"
        case profileImagePath = "profilePictureURL"
    }
}
