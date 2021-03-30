//
//  GetJournalRequest.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/23.
//

import Foundation

// 작성한 일지 조회 api 호출

final class GetJournalRequest: Requestable {
    typealias ResponseType = GetJournalResponse
    
    private var align: String
    private var page: Int
    private var limit: Int
    
    init(align: String, page: Int, limit: Int) {
        self.align = align
        self.page = page
        self.limit = limit
    }
    
    var baseUrl: URL {
        return  URL(string: Constants.BASE_URL)!
    }
    
    var endpoint: String {
        return "journals"
    }
    
    var method: Network.Method {
        return .get
    }
    
    var query: Network.QueryType {
        return .path
    }
    
    var parameters: [String : Any]? {
        return ["align": align, "page": page, "limit": limit] 
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
