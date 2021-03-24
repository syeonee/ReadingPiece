//
//  NameDuplicateResponse.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/03/23.
//

import Foundation

public struct NameDuplicateResponse: Codable {
    public let isSuccess: Bool
    public let code: Int
    public let message: String
}
