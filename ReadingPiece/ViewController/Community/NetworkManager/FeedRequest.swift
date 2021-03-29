//
//  FeedRequest.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/03/29.
//
import Foundation

final class FeedRequest: Requestable {
    typealias ResponseType = FeedResponse
    
    private var token: String
    private var page: Int
    private var limit: Int
    
    init(token: String, page: Int, limit: Int) {
        self.token = token
        self.page = page
        self.limit = limit
    }
    
    var baseUrl: URL {
        return  URL(string: Constants.BASE_URL)!
    }
    
    var endpoint: String {
        return "reading/graph"
    }
    
    var method: Network.Method {
        return .get
    }
    
    var query: Network.QueryType {
        return .path
    }
    
    var parameters: [String : Any]? {
        return ["page": self.page, "limit": self.limit]
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
