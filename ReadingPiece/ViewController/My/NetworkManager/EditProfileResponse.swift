//
//  EditProfileResponse.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/03/24.
//

import Foundation

public struct EditProfileResponse: Codable {
    public let isSuccess: Bool
    public let code: Int
    public let message: String
}
