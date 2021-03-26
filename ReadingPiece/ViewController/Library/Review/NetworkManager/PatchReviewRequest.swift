//
//  PatchReviewRequest.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/24.
//

import Foundation

// 평가 리뷰 별점, 내용, 공개여부 수정 API

final class PatchReviewRequest: Requestable {
    typealias ResponseType = GetReviewResponse
    
    private var token: String
    private var reviewID: Int
    private var star: Int
    private var text: String
    private var isPublic: Int
    init(token: String, reviewID: Int, star: Int, text: String, isPublic: Int) {
        self.token = token
        self.reviewID = reviewID
        self.star = star
        self.text = text
        self.isPublic = isPublic
    }
    
    var baseUrl: URL {
        return  URL(string: "https://dev.maekuswant.shop/")!
    }
    
    var endpoint: String {
        return "/review/\(reviewID)"
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
        return ["x-access-token" : self.token]
    }
    
    var timeout: TimeInterval {
        // 테스트용
        return 5.0
        //return 30.0
    }
    
    var cachePolicy: NSURLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }
}

