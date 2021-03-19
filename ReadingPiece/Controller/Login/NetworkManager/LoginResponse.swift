//
//  LoginResponse.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/19.
//

// 로그인 api 응답구조

struct LoginResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message, jwt: String
}
