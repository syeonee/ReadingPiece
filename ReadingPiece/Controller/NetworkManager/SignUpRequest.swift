import Foundation

// API 문서 : https://docs.google.com/spreadsheets/d/1nY5_ryn5OeViz3lUqXVRPNYvNR4hLHJx4nahqUGKcRo/edit#gid=169769979
// 회원가입 POST API 호출 예시

final class SignUpRequest: Requestable {
    typealias ResponseType = SignUpResponse
    private var email : String
    private var password : String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    var baseUrl: URL {
        return  URL(string: "https://dev.maekuswant.shop/")!
    }
    
    var endpoint: String {
        return "signUp"
    }
    
    var method: Network.Method {
        return .post
    }
    
    var query: Network.QueryType {
        return .json
    }
    
    var parameters: [String : Any]? {
        return ["email": self.email, "password": self.password]
    }
    
    var headers: [String : String]? {
        return defaultJSONHeader
    }
    
    var timeout: TimeInterval {
        return 30.0
    }
    
    var cachePolicy: NSURLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }
}
