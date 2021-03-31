//
//  GetReviewEditRequest.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/27.
//

import Foundation

// 리뷰 수정할 때 기존 데이터 GET

final class GetReviewEditRequest: Requestable {
    typealias ResponseType = GetReviewEditResponse
    
    private var token: String
    private var reviewID: Int
    init(token: String, reviewID: Int) {
        self.token = token
        self.reviewID = reviewID
    }
    
    var baseUrl: URL {
        return  URL(string: Constants.BASE_URL)!
    }
    
    var endpoint: String {
        return "my-review/\(reviewID)"
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
        //return 30.0
    }
    
    var cachePolicy: NSURLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }
}

