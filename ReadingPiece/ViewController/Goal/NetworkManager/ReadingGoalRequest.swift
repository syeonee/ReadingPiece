import Foundation

// API 문서 : https://docs.google.com/spreadsheets/d/1nY5_ryn5OeViz3lUqXVRPNYvNR4hLHJx4nahqUGKcRo/edit#gid=1142417665
// 독서 목표 설정 API

final class ReadingGoalRequest: Requestable {
    typealias ResponseType = ReadingGoalResponse
    private var goal: Goal
    
    init(_ goal: Goal) {
        self.goal = goal
    }
    
    var baseUrl: URL {
        return  URL(string: Constants.DEV_BASE_URL)!
    }
    
    var endpoint: String {
        return "challenge"
    }
    
    var method: Network.Method {
        return .post
    }
    
    var query: Network.QueryType {
        return .json
    }
    
    var parameters: [String : Any]? {
        return ["period": self.goal.period, "amount": self.goal.amount, "time": self.goal.time]
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
