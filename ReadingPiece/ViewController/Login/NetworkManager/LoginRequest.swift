//
//  LoginRequest.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/19.
//

import Foundation

// 로그인 api 호출 클래스

final class LoginRequest: Requestable {
    typealias ResponseType = LoginResponse
    
    private var email: String
    private var password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    var baseUrl: URL {
        return  URL(string: "https://dev.maekuswant.shop/")!
    }
    
    var endpoint: String {
        return "signIn"
    }
    
    var method: Network.Method {
        return .post
    }
    
    var query: Network.QueryType {
        return .json
    }
    
    var parameters: [String : Any]? {
        return ["email": self.email, "password": self.password]
    }
    
    var headers: [String : String]? {
        return defaultJSONHeader
    }
    
    var timeout: TimeInterval {
        return 5.0
        //return 30.0 
    }
    
    var cachePolicy: NSURLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }
}
