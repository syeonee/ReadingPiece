//
//  NameCheckResponse.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/31.
//

import Foundation

// 닉네임 중복체크 Response

struct NameCheckResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
}
