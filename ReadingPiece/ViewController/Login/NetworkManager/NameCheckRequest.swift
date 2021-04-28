//
//  NameCheckRequest.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/31.
//

import Foundation

// 닉네임 중복체크 API

final class NameCheckRequest: Requestable {
    typealias ResponseType = NameCheckResponse
    
    private var name: String
    
    init(name: String) {
        self.name = name
    }
    
    var baseUrl: URL {
        return  URL(string: Constants.BASE_URL)!
    }
    
    var endpoint: String {
        return "user/name"
    }
    
    var method: Network.Method {
        return .get
    }
    
    var query: Network.QueryType {
        return .path
    }
    
    var parameters: [String : Any]? {
        return ["name" : self.name]
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

