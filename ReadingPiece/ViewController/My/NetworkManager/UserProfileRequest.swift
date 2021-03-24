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
    
    init() {
    }
    
    var baseUrl: URL {
        return  URL(string: Constants.DEV_BASE_URL)!
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
        return Constants().testAccessTokenHeader
    }
    
    var timeout: TimeInterval {
        return 5.0
    }
    
    var cachePolicy: NSURLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }
}
