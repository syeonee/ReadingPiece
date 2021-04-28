import Foundation

// API 문서 : https://docs.google.com/spreadsheets/d/1nY5_ryn5OeViz3lUqXVRPNYvNR4hLHJx4nahqUGKcRo/edit?ts=605c4ec0#gid=583204733
// 유저가 읽고 있는 책 삭제 API

final class DeleteChallengeBookRequest: Requestable {
    typealias ResponseType = DeleteChallengeResponse
    
    private var token: String
    private var goalbookId: Int
    
    init(token: String, goalbookId: Int) {
        self.token = token
        self.goalbookId = goalbookId
    }

    var baseUrl: URL {
        return  URL(string: Constants.DEV_BASE_URL)!
    }
    
    var endpoint: String {
        return "challenge/book/\(goalbookId)"
    }
    
    var method: Network.Method {
        return .delete
    }
    
    var query: Network.QueryType {
        return .path
    }
    
    var parameters: [String : Any]? {
        return defaultJSONHeader
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
