//
//  PageURLRequest.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/05/06.
//

import Foundation

final class PageURLRequest: Requestable {
    typealias ResponseType = PageURLResponse
    
    private var token: String
    private var uriId: Int
    
    init(token: String, uriId: Int) {
        self.token = token
        self.uriId = uriId
    }
    
    var baseUrl: URL {
        return  URL(string: Constants.BASE_URL)!
    }
    
    var endpoint: String {
        return "uri/\(self.uriId)"
    }
    
    var method: Network.Method {
        return .get
    }
    
    var query: Network.QueryType {
        return .path
    }
    
    var parameters: [String : Any]? {
        return nil
    }
    
    var headers: [String : String]? {
        return ["x-access-token": token]
    }
    
    var timeout: TimeInterval {
        return 10.0
    }
    
    var cachePolicy: NSURLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }
}
