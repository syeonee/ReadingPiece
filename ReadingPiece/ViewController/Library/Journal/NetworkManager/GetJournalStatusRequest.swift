//
//  GetJournalStatusRequest.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/05/03.
//

import Foundation

// 이미 작성한 일지 내용 조회 api 호출 (ML9)
// https://docs.google.com/spreadsheets/d/1nY5_ryn5OeViz3lUqXVRPNYvNR4hLHJx4nahqUGKcRo/edit?ts=605c4eb4#gid=1377453979

final class GetJournalStatusRequest: Requestable {
    typealias ResponseType = GetJournalStatusResponse
    
    private var token: String
    private var journalId: Int
    
    init(token: String, journalId: Int) {
        self.token = token
        self.journalId = journalId
    }
    
    var baseUrl: URL {
        return  URL(string: Constants.BASE_URL)!
    }
    
    var endpoint: String {
        return "journals/\(self.journalId)"
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
    }
    
    var cachePolicy: NSURLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }
}
