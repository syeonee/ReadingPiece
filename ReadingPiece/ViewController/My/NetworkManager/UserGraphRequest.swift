//
//  UserGraphRequest.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/03/29.
//
import Foundation

final class UserGraphRequest: Requestable {
    typealias ResponseType = UserGraphResponse
    
    private var token: String
    private var year: Int
    
    init(token: String, year: Int) {
        self.token = token
        self.year = year
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
        return ["year": self.year]
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
