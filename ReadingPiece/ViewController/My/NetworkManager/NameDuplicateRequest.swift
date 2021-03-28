//
//  NameDuplicateRequest.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/03/23.
//

import Foundation

final class NameDuplicateRequest: Requestable {
    typealias ResponseType = NameDuplicateResponse
    
    private var name: String
    private var token: String
    
    init(token: String, name: String) {
        self.token = token
        self.name = name
    }
    
    var baseUrl: URL {
        return  URL(string: Constants.DEV_BASE_URL)!
    }
    
    var endpoint: String {
        return "name"
    }
    
    var method: Network.Method {
        return .get
    }
    
    var query: Network.QueryType {
        return .path
    }
    
    var parameters: [String : Any]? {
        return ["name": self.name]
    }
    
    var headers: [String : String]? {
        return ["x-access-token" : self.token]
    }
    
    var timeout: TimeInterval {
        return 10.0
    }
    
    var cachePolicy: NSURLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }
}
