import Foundation

// API 문서 : https://docs.google.com/spreadsheets/d/1nY5_ryn5OeViz3lUqXVRPNYvNR4hLHJx4nahqUGKcRo/edit?ts=605c4ec0#gid=1204762242
// 유저가 읽고 있는 책 변경 API

final class PatchChallengeBookRequest: Requestable {
    typealias ResponseType = DeleteChallengeResponse // 삭제와 응답코드가 같아서 재활용
    
    private var token: String
    private var goalbookId: Int
    
    init(token: String, goalbookId: Int) {
        self.token = token
        self.goalbookId = goalbookId
    }

    var baseUrl: URL {
        return  URL(string: Constants.DEV_BASE_URL)!
    }
    
    var endpoint: String {
        return "challenge/goal/book/\(self.goalbookId)"
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
