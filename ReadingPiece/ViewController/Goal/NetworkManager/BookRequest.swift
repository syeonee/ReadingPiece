import Foundation

// API 문서 : https://docs.google.com/spreadsheets/d/1nY5_ryn5OeViz3lUqXVRPNYvNR4hLHJx4nahqUGKcRo/edit#gid=182560157
// 책 추가 API
final class AddBookRequest: Requestable {
    typealias ResponseType = BookResponse
    private var goalId: Int
    private var isbn: String
    
    init(goalId: Int, isbn: String) {
        self.goalId = goalId
        self.isbn = isbn
    }
    
    var baseUrl: URL {
        return  URL(string: Constants.DEV_BASE_URL)!
    }
    
    var endpoint: String {
        return "challenge/book"
    }
    
    var method: Network.Method {
        return .post
    }
    
    var query: Network.QueryType {
        return .json
    }
    
    
    var parameters: [String : Any]? {
        return ["goalId": self.goalId, "publishNumber": self.isbn]
    }
    
    var headers: [String : String]? {
        return Constants().testAccessTokenHeader
    }
    
    var timeout: TimeInterval {
        return 30.0
    }
    
    var cachePolicy: NSURLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }
}
