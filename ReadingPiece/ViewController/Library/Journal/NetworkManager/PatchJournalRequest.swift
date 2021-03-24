//
//  PatchJournalRequest.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/24.
//

import Foundation
// 일지 수정 api 호출 클래스

final class PatchJournalRequest: Requestable {
    typealias ResponseType = GetJournalResponse
    
    private var token: String
    private var text: String
    // var open // 공개 여부 변수 추가하기
    private var journalID: Int
    init(token: String, text: String, journalID: Int) {
        self.token = token
        self.text = text
        self.journalID = journalID
    }
    
    var baseUrl: URL {
        return  URL(string: "https://dev.maekuswant.shop/")!
    }
    
    var endpoint: String {
        return "/journals"
    }
    
    var method: Network.Method {
        return .patch
    }
    
    var query: Network.QueryType {
        return .json
    }
    
    var parameters: [String : Any]? {
        return ["text": self.text, "open": "", "journalId": self.journalID]
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

