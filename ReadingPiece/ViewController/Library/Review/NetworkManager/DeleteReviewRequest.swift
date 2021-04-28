//
//  DeleteReviewRequest.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/24.
//

import Foundation

// 리뷰 삭제 API

final class DeleteReviewRequest: Requestable {
    typealias ResponseType = GetReviewResponse
    
    private var token: String
    private var reviewID: Int
    init(token: String , reviewID: Int) {
        self.token = token
        self.reviewID = reviewID
    }
    
    var baseUrl: URL {
        return  URL(string: Constants.BASE_URL)!
    }
    
    var endpoint: String {
        return "review/\(reviewID)"
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


