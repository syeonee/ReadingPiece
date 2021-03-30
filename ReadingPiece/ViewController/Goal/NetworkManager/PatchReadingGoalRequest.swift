import Foundation

// API 문서 : https://docs.google.com/spreadsheets/d/1nY5_ryn5OeViz3lUqXVRPNYvNR4hLHJx4nahqUGKcRo/edit#gid=602362630
// 독서 목표 변경 API

final class PatchReadingGoalRequest: Requestable {
    typealias ResponseType = PatchReadingGoalResponse
    private var goal: Goal
    private var goalId: Int
    
    init(_ goal: Goal, goalId: Int) {
        self.goal = goal
        self.goalId = goalId
    }

    var baseUrl: URL {
        return  URL(string: Constants.DEV_BASE_URL)!
    }
    
    var endpoint: String {
        return "challenge"
    }
    
    var method: Network.Method {
        return .patch
    }
    
    var query: Network.QueryType {
        return .json
        
    }
    
    var parameters: [String : Any]? {
        return ["period": self.goal.period, "amount": self.goal.amount, "time": self.goal.time, "goalId": self.goalId]
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
