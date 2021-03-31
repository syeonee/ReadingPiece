import Foundation

// API 문서 : https://docs.google.com/spreadsheets/d/1nY5_ryn5OeViz3lUqXVRPNYvNR4hLHJx4nahqUGKcRo/edit?ts=605c4ec0#gid=1957619493
// 부적절한 리뷰 신고 API

final class PostReportReviewRequest: Requestable {
    typealias ResponseType = DeleteChallengeResponse // 응답코드가 같아서 재활용
    
    private var reviewId: Int
    private var token: String
    
    init(reviewId: Int, token: String) {
        self.reviewId = reviewId
        self.token = token
    }

    var baseUrl: URL {
        return  URL(string: Constants.DEV_BASE_URL)!
    }
    
    var endpoint: String {
        return "challenge/goal/book/\(self.reviewId)"
    }
    
    var method: Network.Method {
        return .post
    }
    
    var query: Network.QueryType {
        return .json
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
