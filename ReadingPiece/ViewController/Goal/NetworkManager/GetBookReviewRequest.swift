import Foundation

// API 문서 : https://docs.google.com/spreadsheets/d/1nY5_ryn5OeViz3lUqXVRPNYvNR4hLHJx4nahqUGKcRo/edit#gid=1168939781
// 각 책에대한 상세 정보, 리뷰 조회 API
final class GetBookReviewRequest: Requestable {
    typealias ResponseType = BookReviewResponse
    private var isbn: String
    private var goalBookId: String
    
    init(isbn: String, goalBookId: String) {
        self.isbn = isbn
        self.goalBookId = goalBookId
    }
    
    var baseUrl: URL {
        return  URL(string: Constants.DEV_BASE_URL)!
    }
    
    var endpoint: String {
        return "book/\(self.goalBookId)"
    }
    
    var method: Network.Method {
        return .get
    }
    
    var query: Network.QueryType {
        return .json
    }
    
    
    var parameters: [String : Any]? {
        return ["publishNumber": self.isbn]
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
