//
//  LoginResponse.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/19.
//

// 로그인, 회원가입 api 응답구조

public struct LoginResponse: Codable {
    public let isSuccess: Bool
    public let code: Int
    public let message: String
    public let jwt: String?
}
