import Foundation

// API 문서 : https://apidocs.bithumb.com/docs/order_book
// 테스트용 GET API 호출
final class BithumbRequest: Requestable {
    typealias ResponseType = BithumbResponse
    private var orderCurrency : String
    private var paymentCurrency : String
    
    init(order: String, payment: String) {
        self.orderCurrency = order
        self.paymentCurrency = payment
    }
    
    var baseUrl: URL {
        return  URL(string: "https://api.bithumb.com/public/")!
    }
    
    var endpoint: String {
        return "orderbook/\(orderCurrency)_\(paymentCurrency)"
    }
    
    var method: Network.Method {
        return .get
    }
    
    var query: Network.QueryType {
        return .path
    }
    
    var parameters: [String : Any]? {
        return nil
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
