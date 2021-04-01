//
//  PasswordResetRequest.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/28.
//

import Foundation

// 회원 탈퇴 API
final class PasswordResetRequest: Requestable {
    typealias ResponseType = CloseAccountResponse
    
    private var presentPW: String // 기존 비밀번호
    private var password: String // 새로운 비밀번호
    private var token : String
    
    init(token: String, presentPW: String, password: String) {
        self.token = token
        self.presentPW = presentPW
        self.password = password
    }
    
    var baseUrl: URL {
        return  URL(string: Constants.BASE_URL)!
    }
    
    var endpoint: String {
        return "reset"
    }
    
    var method: Network.Method {
        return .patch
    }
    
    var query: Network.QueryType {
        return .json
    }
    
    var parameters: [String : Any]? {
        return ["password" : self.password, "presentPW" : self.presentPW]
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json", "x-access-token": self.token]
    }
    
    var timeout: TimeInterval {
        return 10.0
    }
    
    var cachePolicy: NSURLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }
}
