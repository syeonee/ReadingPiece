import Foundation
import KeychainSwift

// API 문서 : https://docs.google.com/spreadsheets/d/1nY5_ryn5OeViz3lUqXVRPNYvNR4hLHJx4nahqUGKcRo/edit#gid=1168939781
// 각 책에대한 상세 정보, 리뷰 조회 API
final class GetUserBookReviewRequest: Requestable {
    typealias ResponseType = UserBookReviewResponse
    private var isbn: String
    private var bookId: String
    
    init(isbn: String, bookId: String) {
        self.isbn = isbn
        self.bookId = bookId
    }
    
    var baseUrl: URL {
        return  URL(string: Constants.DEV_BASE_URL)!
    }
    
    var endpoint: String {
        return "book/\(bookId)"
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
        return 30.0
    }
    
    var cachePolicy: NSURLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }
}
