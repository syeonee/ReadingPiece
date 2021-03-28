//
//  GetJournalImageRequest.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/27.
//

import Foundation

// 일지 사진 불러오기 요청

final class GetJournalImageRequest: Requestable {
    typealias ResponseType = GetJournalImageResponse
    
    private var journalID: Int
    init(journalID: Int) {
        self.journalID = journalID
    }
    
    var baseUrl: URL {
        return  URL(string: "https://dev.maekuswant.shop/")!
    }
    
    var endpoint: String {
        return "journals/\(journalID)"
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