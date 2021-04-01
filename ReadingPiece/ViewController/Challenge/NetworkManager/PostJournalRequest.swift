import Foundation

// API 문서 : https://docs.google.com/spreadsheets/d/1nY5_ryn5OeViz3lUqXVRPNYvNR4hLHJx4nahqUGKcRo/edit?ts=605c4ec0#gid=1235613435
// 일지 작성 API

final class PostJournalRequest: Requestable {
    typealias ResponseType = PostJournalResponse
    
    private var token: String
    private var journal: JournalWritten
    
    init(token: String, journal: JournalWritten) {
        self.token = token
        self.journal = journal
    }

    var baseUrl: URL {
        return  URL(string: Constants.DEV_BASE_URL)!
    }
    
    var endpoint: String {
        return "journals"
    }
    
    var method: Network.Method {
        return .post
    }
    
    var query: Network.QueryType {
        return .json
    }
    
    var parameters: [String : Any]? {
        return ["page": journal.time, "goalBookId": journal.goalBookId, "time": journal.time,
                "text": journal.text, "open": journal.open, "percent": journal.percent ]
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json", "x-access-token": token]
    }
    
    var timeout: TimeInterval {
        return 10.0
    }
    
    var cachePolicy: NSURLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }
}

// 일지 작성 API 호출에 필요한 데이터만 모은 구조체
public struct JournalWritten {
    var time: Int
    var text: String
    var open: String
    var goalBookId: Int
    var page: Int
    var percent: Int
}

// 스펙 변경으로 이미지 첨부는 필드에서 제외, 추후 추가
//var journalImageURL: String?
//var goalId: Int
