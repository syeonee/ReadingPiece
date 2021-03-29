//
//  PatchReviewRequest.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/27.
//

import Foundation

// 리뷰 수정 리퀘스트

final class PatchReviewRequest: Requestable {
    typealias ResponseType = GetReviewResponse
    
    private var reviewID: Int
    private var star: Int
    private var text: String
    private var isPublic: Int
    init(reviewID: Int, star: Int, text: String, isPublic: Int) {
        self.reviewID = reviewID
        self.star = star
        self.text = text
        self.isPublic = isPublic
    } 
    
    var baseUrl: URL {
        return  URL(string: Constants.BASE_URL)!
    }
    
    var endpoint: String {
        return "review/\(self.reviewID)"
    }
    
    var method: Network.Method {
        return .patch
    }
    
    var query: Network.QueryType {
        return .json
    }
    
    var parameters: [String : Any]? {
        return ["star": star, "text": text, "isPublic": isPublic]
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

