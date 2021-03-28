import Foundation

// API 문서 : https://docs.google.com/spreadsheets/d/1nY5_ryn5OeViz3lUqXVRPNYvNR4hLHJx4nahqUGKcRo/edit?ts=605c4ec0#gid=1204762242
// 유저가 읽고 있는 책 변경 API

final class PostUserCakeTypeRequest: Requestable {
    typealias ResponseType = PostCakeTypeResponse
    
    private var goalId: Int
    private var cake: String
    
    init(goalId: Int, cake: String) {
        self.goalId = goalId
        self.cake = cake
    }

    var baseUrl: URL {
        return  URL(string: Constants.DEV_BASE_URL)!
    }
    
    var endpoint: String {
        return "cake"
    }
    
    var method: Network.Method {
        return .post
    }
    
    var query: Network.QueryType {
        return .json
    }
    
    var parameters: [String : Any]? {
        return ["goalId": self.goalId, "cake": self.cake]
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