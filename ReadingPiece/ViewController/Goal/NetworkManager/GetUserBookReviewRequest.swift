import Foundation
import KeychainSwift

// API 문서 : https://docs.google.com/spreadsheets/d/1nY5_ryn5OeViz3lUqXVRPNYvNR4hLHJx4nahqUGKcRo/edit#gid=1168939781
// 각 책에대한 상세 정보, 리뷰 조회 API
final class GetUserBookReviewRequest: Requestable {
    typealias ResponseType = UserBookReviewResponse
    private var isbn: String
    private var token: String
    
    init(isbn: String, token: String) {
        self.isbn = isbn
        self.token = token
    }
    
    var baseUrl: URL {
        return  URL(string: Constants.BASE_URL)!
    }
    
    var endpoint: String {
//        return "book?publishNumber=\(isbn)"
        return "book"
    }
    
    var method: Network.Method {
        return .get
    }
    
    var query: Network.QueryType {
        return .path
    }
    
    
    var parameters: [String : Any]? {
        return ["publishNumber": isbn]
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json", "x-access-token": self.token]
    }
    
    var timeout: TimeInterval {
        return 5.0
    }
    
    var cachePolicy: NSURLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }
}
