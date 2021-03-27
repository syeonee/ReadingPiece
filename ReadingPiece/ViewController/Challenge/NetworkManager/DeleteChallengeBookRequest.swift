import Foundation

// API 문서 : https://docs.google.com/spreadsheets/d/1nY5_ryn5OeViz3lUqXVRPNYvNR4hLHJx4nahqUGKcRo/edit?ts=605c4ec0#gid=583204733
// 유저가 읽고 있는 책 삭제 API

final class DeleteChallengeBookRequest: Requestable {
    typealias ResponseType = DeleteChallengeResponse
    
    private var goalbookId: Int
    
    init(goalbookId: Int) {
        self.goalbookId = goalbookId
    }

    var baseUrl: URL {
        return  URL(string: Constants.DEV_BASE_URL)!
    }
    
    var endpoint: String {
        return "challenge/book"
    }
    
    var method: Network.Method {
        return .delete
    }
    
    var query: Network.QueryType {
        return .json
    }
    
    var parameters: [String : Any]? {
        return ["goalbookId": self.goalbookId]
    }
    
    var headers: [String : String]? {
        return Constants().ACCESS_TOKEN_HEADER
    }
    
    var timeout: TimeInterval {
        return 30.0
    }
    
    var cachePolicy: NSURLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }
}
