//
//  EmailRequest.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/28.
//

import Foundation

final class EmailRequest: Requestable {
    typealias ResponseType = LoginResponse
    
    private var email: String
    
    init(email: String) {
        self.email = email
    }
    
    var baseUrl: URL {
        return  URL(string: "https://dev.maekuswant.shop/")!
    }
    
    var endpoint: String {
        return "email"
    }
    
    var method: Network.Method {
        return .post
    }
    
    var query: Network.QueryType {
        return .json
    }
    
    var parameters: [String : Any]? {
        return ["email" : self.email]
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
