//
//  DeleteJournalRequest.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/24.
//

import Foundation

// 일지 삭제 api 호출 (ML7)
// https://docs.google.com/spreadsheets/d/1nY5_ryn5OeViz3lUqXVRPNYvNR4hLHJx4nahqUGKcRo/edit?ts=605c4eb4#gid=771765964

final class DeleteJournalRequest: Requestable {
    typealias ResponseType = DeleteJournalResponse
    
    private var token: String
    private var journalID: Int
    init(token: String, journalID: Int) {
        self.token = token
        self.journalID = journalID
    }
    
    var baseUrl: URL {
        return  URL(string: Constants.BASE_URL)!
    }
    
    var endpoint: String {
        return "journals/\(journalID)"
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
    }
    
    var cachePolicy: NSURLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }
}
