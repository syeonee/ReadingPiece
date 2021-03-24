//
//  DeleteReviewRequest.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/24.
//

import Foundation

// 리뷰 삭제 API

final class DeleteReviewRequest: Requestable {
    typealias ResponseType = GetJournalResponse
    
    private var token: String
    private var reviewID: Int
    init(token: String, reviewID: Int) {
        self.token = token
        self.reviewID = reviewID
    }
    
    var baseUrl: URL {
        return  URL(string: "https://dev.maekuswant.shop/")!
    }
    
    var endpoint: String {
        return "/review/\(reviewID)"
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


