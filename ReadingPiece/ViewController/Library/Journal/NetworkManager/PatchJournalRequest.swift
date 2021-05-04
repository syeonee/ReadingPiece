//
//  PatchJournalRequest.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/05/03.
//

import Foundation

// 작성한 일지 수정 api 호출 (ML8)
//https://docs.google.com/spreadsheets/d/1nY5_ryn5OeViz3lUqXVRPNYvNR4hLHJx4nahqUGKcRo/edit?ts=605c4eb4#gid=24512929

final class PatchJournalRequest: Requestable {
    typealias ResponseType = PatchJournalResponse
    
    private var token: String
    private var text: String
    private var journalImageURL: String?
    private var open: String
    private var journalId: Int
    
    init(token: String, text: String, open: String, journalId: Int) {
        self.token = token
        self.text = text
        self.open = open
        self.journalId = journalId
    }
    
    var baseUrl: URL {
        return  URL(string: Constants.BASE_URL)!
    }
    
    var endpoint: String {
        return "journals"
    }
    
    var method: Network.Method {
        return .patch
    }
    
    var query: Network.QueryType {
        return .json
    }
    
    var parameters: [String : Any]? {
        if let url = self.journalImageURL {
            return ["text": self.text, "journalImageURL": url, "open": self.open, "journalId": self.journalId]
        } else {
            return ["text": self.text, "open": self.open, "journalId": self.journalId]
        }
    }
    
    var headers: [String : String]? {
        return ["x-access-token": token, "Content-Type": "application/json"]
    }
    
    var timeout: TimeInterval {
        return 10.0
    }
    
    var cachePolicy: NSURLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }
}
