import Foundation

// API 문서 : https://docs.google.com/spreadsheets/d/1nY5_ryn5OeViz3lUqXVRPNYvNR4hLHJx4nahqUGKcRo/edit#gid=182560157
// 챌린지에 사용할 책 추가 API
final class PostChallengeBookRequest: Requestable {
    typealias ResponseType = PostChalleneBookResponse
    private var goalId: Int
    private var bookId: Int
    private var isbn: String
    
    init(goalId: Int, isbn: String, bookId: Int) {
        self.goalId = goalId
        self.isbn = isbn
        self.bookId = bookId
        
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
        return ["goalId": self.goalId, "publishNumber": self.isbn, "bookId": self.bookId]
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
