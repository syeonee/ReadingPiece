import Foundation

// API 문서 : https://docs.google.com/spreadsheets/d/1nY5_ryn5OeViz3lUqXVRPNYvNR4hLHJx4nahqUGKcRo/edit#gid=706704690
// 현재 읽고 있는 책의 독서시간(타이머) 조회 API

final class GetBookReadingTimeRequest: Requestable {
    typealias ResponseType = ReadingBookTimeResponse
    private var goalBookId: Int
    
    init(goalBookId: Int) {
        self.goalBookId = goalBookId
    }

    var baseUrl: URL {
        return  URL(string: Constants.DEV_BASE_URL)!
    }
    
    var endpoint: String {
        return "challenge/\(self.goalBookId)/times"
    }
    
    var method: Network.Method {
        return .get
    }
    
    var query: Network.QueryType {
        return .path
    }
    
    var parameters: [String : Any]? {
        return defaultJSONHeader
    }
    
    var headers: [String : String]? {
        return Constants().ACCESS_TOKEN_HEADER
    }
    
    var timeout: TimeInterval {
        return 5.0
    }
    
    var cachePolicy: NSURLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }
}
