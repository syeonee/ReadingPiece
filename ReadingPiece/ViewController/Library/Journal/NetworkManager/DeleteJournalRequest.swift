//
//  DeleteJournalRequest.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/24.
//

import Foundation
// 일지 삭제 api 호출 클래스

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
