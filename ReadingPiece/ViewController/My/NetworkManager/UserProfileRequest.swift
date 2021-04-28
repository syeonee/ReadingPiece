//
//  UserProfileRequest.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/03/23.
//

import Foundation

// API 문서 : https://docs.google.com/spreadsheets/d/1nY5_ryn5OeViz3lUqXVRPNYvNR4hLHJx4nahqUGKcRo/edit#gid=1844912744
// 내 프로필 조회 API

final class UserProfileRequest: Requestable {
    typealias ResponseType = UserProfileResponse
    
    private var token: String
    
    init(token: String) {
        self.token = token
    }
    
    var baseUrl: URL {
        return  URL(string: Constants.BASE_URL)!
    }
    
    var endpoint: String {
        return "profile"
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
