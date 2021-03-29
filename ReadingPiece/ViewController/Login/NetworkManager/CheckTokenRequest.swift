//
//  CheckTokenRequest.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/25.
//

import Foundation
import Alamofire

// 토큰 유효성 검사

final class CheckTokenRequest: Requestable {
    typealias ResponseType = CheckTokenResponse
    
    private var token: String
    
    init(token: String) {
        self.token = token
    }
    
    var baseUrl: URL {
        return  URL(string: Constants.BASE_URL)!
    }
    
    var endpoint: String {
        return "check"
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
        return ["x-access-token" : self.token]
    }
    
    var timeout: TimeInterval {
        return 10.0
        //return 30.0
    }
    
    var cachePolicy: NSURLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }
}
