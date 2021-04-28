//
//  PostJournalRequest.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/24.
//

import Foundation

// 리뷰 생성 api 호출

final class PostReviewRequest: Requestable {
    typealias ResponseType = GetReviewResponse
    
    private var token: String
    private var bookID: Int
    private var star: Int
    private var text: String
    private var isPublic: Int
    init(token: String, bookID: Int, star: Int, text: String, isPublic: Int) {
        self.token = token
        self.bookID = bookID
        self.star = star
        self.text = text
        self.isPublic = isPublic
    }
    
    var baseUrl: URL {
        return  URL(string: Constants.BASE_URL)!
    }
    
    var endpoint: String {
        return "review"
    }
    
    var method: Network.Method {
        return .post
    }
    
    var query: Network.QueryType {
        return .json
    }
    
    var parameters: [String : Any]? {
        return ["bookId": bookID, "star": star, "text": text, "isPublic": isPublic]
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json", "x-access-token": token]
    }
    
    var timeout: TimeInterval {
        return 10.0
        //return 30.0
    }
    
    var cachePolicy: NSURLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }
}
