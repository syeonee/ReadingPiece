import Foundation

// API 문서 : https://docs.google.com/spreadsheets/d/1nY5_ryn5OeViz3lUqXVRPNYvNR4hLHJx4nahqUGKcRo/edit?ts=605c4ec0#gid=1235613435
// 일지 작성 API

final class PostJournalRequest: Requestable {
    typealias ResponseType = PostJournalResponse
    
    private var journal: JournalWritten
    
    init(journal: JournalWritten) {
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
                "text": journal.text, "journalImageURL": journal.journalImageURL, "open": journal.open, "percent": journal.percent ]
    }
    
    var headers: [String : String]? {
        return Constants().ACCESS_TOKEN_HEADER
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
    var journalImageURL: String?
    var open: String
    var goalBookId: Int
    var page: Int
    var percent: Int
    var goalId: Int
}
