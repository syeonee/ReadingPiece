//
//  User.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/22.
//

import Foundation

struct Keys {
    static let keyPrefix = "readingPiece_"
    static let token = "token"
    static let userIdentifier = "userIdentifier"
}

struct User: Codable {
    let name: String
    let email: String
    let userIdentifier: String
}
