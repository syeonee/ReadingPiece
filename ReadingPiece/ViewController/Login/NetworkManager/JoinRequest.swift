//
//  JoinRequest.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/18.
//

import Foundation

// 회원가입 api 호출 클래스

final class JoinRequest: Requestable {
    typealias ResponseType = JoinResponse
    
    private var name: String
    private var email: String
    private var password: String
    
    init(name: String, email: String, password: String) {
        self.name = name
        self.email = email
        self.password = password
    }
    
    var baseUrl: URL {
        return  URL(string: Constants.BASE_URL)!
    }
    
    var endpoint: String {
        return "join"
    }
    
    var method: Network.Method {
        return .post
    }
    
    var query: Network.QueryType {
        return .json
    }
    
    var parameters: [String : Any]? {
        return ["email": self.email, "password": self.password, "name" : self.name]
    }
    
    var headers: [String : String]? {
        return defaultJSONHeader
    }
    
    var timeout: TimeInterval {
        return 10.0
    }
    
    var cachePolicy: NSURLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }
}
