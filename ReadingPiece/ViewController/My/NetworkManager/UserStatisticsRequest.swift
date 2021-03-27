//
//  UserStatisticsRequest.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/03/28.
//

import Foundation

final class UserStatisticsRequest: Requestable {
    typealias ResponseType = UserStatisticsResponse
    
    private var token: String
    
    init(token: String) {
        self.token = token
    }
    
    var baseUrl: URL {
        return  URL(string: Constants.DEV_BASE_URL)!
    }
    
    var endpoint: String {
        return "reading-info"
    }
    
    var method: Network.Method {
        return .get
    }
    
    var query: Network.QueryType {
        return .json
    }
    
    var parameters: [String : Any]? {
        return nil
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
