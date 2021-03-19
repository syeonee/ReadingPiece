//
//  JoinRequest.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/18.
//

import Foundation

final class JoinRequest: Requestable {
    typealias ResponseType = JoinResponse
    
    private var userInfo: [String : String]
    
    init(userInfo: [String : String]) {
        self.userInfo = userInfo
    }
    
    var baseUrl: URL {
        return  URL(string: "dev.maekuswant.shop")!
    }
    
    var endpoint: String {
        return "/signUp"
    }
    
    var method: Network.Method {
        return .post
    }
    
    var query: Network.QueryType {
        return .path
    }
    
    var parameters: [String : Any]? {
        return userInfo
    }
    
    var headers: [String : String]? {
        return defaultJSONHeader
    }
    
    var timeout: TimeInterval {
        return 30.0
    }
    
    var cachePolicy: NSURLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }
}
