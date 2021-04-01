import Foundation

// API 문서 : https://docs.google.com/spreadsheets/d/1nY5_ryn5OeViz3lUqXVRPNYvNR4hLHJx4nahqUGKcRo/edit?ts=605c4ec0#gid=616502883
// 만료된 챌린지 그대로 재시작하는 API

final class PatchRestartChallengeRequest: Requestable {
    typealias ResponseType = DeleteChallengeResponse // 삭제와 응답코드가 같아서 재활용
    
    private var token: String
    
    init(token: String) {
        self.token = token
    }

    var baseUrl: URL {
        return  URL(string: Constants.DEV_BASE_URL)!
    }
    
    var endpoint: String {
        return "challenge/expiration"
    }
    
    var method: Network.Method {
        return .patch
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
        return 5.0
    }
    
    var cachePolicy: NSURLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }
}
