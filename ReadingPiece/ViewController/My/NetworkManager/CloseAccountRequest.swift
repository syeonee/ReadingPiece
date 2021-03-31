//
//  CloseAccountRequest.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/28.
//

import Foundation

// 회원 탈퇴 API
final class CloseAccountRequest: Requestable {
    typealias ResponseType = CloseAccountResponse
    
    private var token: String
    
    init(token: String) {
        self.token = token
    }
    
    var baseUrl: URL {
        return  URL(string: Constants.BASE_URL)!
    }
    
    var endpoint: String {
        return "bye"
    }
    
    var method: Network.Method {
        return .delete
    }
    
    var query: Network.QueryType {
        return .path
    }
    
    var parameters: [String : Any]? {
        return nil
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json", "x-access-token": self.token]
    }
    
    var timeout: TimeInterval {
        return 10.0
    }
    
    var cachePolicy: NSURLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }
}
