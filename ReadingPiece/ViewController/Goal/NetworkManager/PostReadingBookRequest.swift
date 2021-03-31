import Foundation

// API 문서 : https://docs.google.com/spreadsheets/d/1nY5_ryn5OeViz3lUqXVRPNYvNR4hLHJx4nahqUGKcRo/edit#gid=302192116
// 챌린지 외에 그냥 읽고 있는 책 추가 API
final class AddBookRequest: Requestable {
    typealias ResponseType = BookResponse
    private var book: GeneralBook
    private var token: String
    
    init(book: GeneralBook, token: String) {
        self.book = book
        self.token = token
    }
    
    var baseUrl: URL {
        return  URL(string: Constants.DEV_BASE_URL)!
    }
    
    var endpoint: String {
        return "book"
    }
    
    var method: Network.Method {
        return .post
    }
    
    var query: Network.QueryType {
        return .json
    }
    
    
    var parameters: [String : Any]? {
        return ["writer": self.book.writer, "publishDate": self.book.publishDate, "publishNumber": self.book.publishNumber,
                "contents": self.book.contents , "imageURL": self.book.imageURL, "title": self.book.title, "publisher": self.book.publisher ]
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
