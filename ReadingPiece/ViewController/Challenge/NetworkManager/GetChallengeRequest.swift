import Foundation
import SwiftyJSON
import Alamofire

// API 문서 : https://docs.google.com/spreadsheets/d/1nY5_ryn5OeViz3lUqXVRPNYvNR4hLHJx4nahqUGKcRo/edit#gid=2070942099
// 챌린지 현황 조회 API

final class GetChallengeRequest: Requestable {
    typealias ResponseType = ChallengeResponse
    
    private var token: String
    init(token: String) {
        self.token = token
    }
    
    var baseUrl: URL {
        return  URL(string: Constants.BASE_URL)!
    }
    
    var endpoint: String {
        return "challenge"
    }
    
    var method: Network.Method {
        return .get
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

struct getChallengeRequest {
    func getChallengeRequest(completion:@escaping (ChallengerInfo?) -> Void) {
        let reqUrl =  "https://prod.maekuswant.shop/challenge"
        let tokenHeader = HTTPHeader(name: "x-access-token", value: Constants.KEYCHAIN_TOKEN ?? "")
        let typeHeader = HTTPHeader(name: "Content-Type", value: "application/json")
        let header = HTTPHeaders([typeHeader, tokenHeader])
        
        AF.request(reqUrl, method: .get, headers: header).validate(statusCode: 200..<300).responseJSON { response in
            switch(response.result) {
            case .success(_) :
                if let data = response.data {
                    guard let jsonData = try? JSON(data: data) else { return }
                    let isSuccess = jsonData["isSuccess"].boolValue
                    let responseCode = jsonData["code"].intValue
                    let message = jsonData["message"].stringValue
                    let isExpired = jsonData["isExpired"].boolValue

                    if isSuccess == true {
                        print("LOG - 책, 챌린지, 목표 정보 조회 성공")

                        let goalBookInfo = jsonData["getchallenge1Rows"].arrayValue
                        let challengeStatus = jsonData["getchallenge2Rows"].arrayValue
                        guard let todayReadingJson = jsonData["getchallenge3Rows"].arrayValue.first else { return }

                        let books =  goalBookInfo.compactMap{ getBookInfoFromJson(json: $0) }
                        let challengeStatusList = challengeStatus.compactMap{ getReadingGoalFromJson(json: $0)}
                        let todayReading = getChallengeFromJson(json: todayReadingJson)
                        let challengerInfo = ChallengerInfo(readingBook: books, readingGoal: challengeStatusList, todayChallenge: todayReading, isExpired: isExpired)
                        
                        completion(challengerInfo)
                    } else {
                        print("파싱결과 : 도전하고 있는 책 정보 없음", isSuccess, responseCode, message)
                        completion(nil)
                    }
                }
                break ;
            case .failure(_):
                print("LOG - 책, 챌린지, 목표 정보 조회 실패")
                completion(nil)
                break;
            }
        }
    }

    private func getBookInfoFromJson(json: JSON) -> ReadingBook {
        let goalId = json["goalId"].intValue
        let bookId = json["bookId"].intValue
        let title = json["title"].stringValue
        let writer = json["writer"].stringValue
        let imageUrl = json["imageURL"].stringValue
        let isbn = json["publishNumber"].stringValue
        let goalBookId = json["goalBookId"].intValue
        let isComplete = json["isComplete"].intValue

        let chllengeReadingBook = ReadingBook(goalId: goalId, bookId: bookId, title: title, writer: writer, imageURL: imageUrl, publishNumber: isbn, goalBookId: goalBookId, isComplete: isComplete)

        return chllengeReadingBook
    }

    private func getReadingGoalFromJson(json: JSON) -> ReadingGoal {
        let goalBookId = json["goalBookId"].intValue
        let page = json["page"].intValue
        let percent = json["percent"].intValue
        let totalReadingTime = json["sum(time)"].stringValue
        let isReading = json["isReading"].stringValue

        let readongGoal = ReadingGoal(goalBookId: goalBookId, page: page, percent: percent, totalTime: totalReadingTime, isReading: isReading)

        return readongGoal
    }

    private func getChallengeFromJson(json: JSON) -> Challenge {
        let totalJournal = json["sumjournal"].intValue
        let todayReadingTime = json["todayTime"].string
        let amount = json["amount"].intValue
        let time = json["time"].intValue
        let period = json["period"].stringValue
        let userId = json["userId"].intValue
        let totalReadingBook = json["sumAmount"].intValue
        let name = json["name"].stringValue
        let expriodAt = json["expriodAt"].stringValue
        let dDay = json["Dday"].intValue
        let challengeId = json["challengeId"].intValue

        let challenge = Challenge(totalJournal: totalJournal, todayTime: todayReadingTime, amount: amount, time: time, period: period, userId: userId,
                                  totalReadBook: totalReadingBook, name: name, expriodAt: expriodAt, dDay: dDay, challengeId: challengeId)

        return challenge
    }

}

// CH2 API에서 받아온 정보들을 모두 합쳐서 반환한 객체
struct ChallengerInfo {
    var readingBook : [ReadingBook]
    var readingGoal : [ReadingGoal]
    var todayChallenge : Challenge
    var isExpired: Bool
}
