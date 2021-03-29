//
//  GetReviewRequest.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/25.
//

import Foundation


// 내 평가/리뷰 조회 요청

final class GetReviewRequest: Requestable {
    typealias ResponseType = GetReviewResponse
    
    private var align: String
    init(align: String) {
        self.align = align
    }
    var baseUrl: URL {
        return  URL(string: Constants.BASE_URL)!
    }
    
    var endpoint: String {
        return "my-review"
    }
    
    var method: Network.Method {
        return .get
    }
    
    var query: Network.QueryType {
        return .path
    }
    
    var parameters: [String : Any]? {
        return ["align": align]
    }
    
    var headers: [String : String]? {
        return Constants().ACCESS_TOKEN_HEADER
    }
    
    var timeout: TimeInterval {
        return 10.0
        //return 30.0
    }
    
    var cachePolicy: NSURLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }
}


