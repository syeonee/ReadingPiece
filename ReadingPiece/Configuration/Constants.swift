//
//  Constants.swift
//  ReadingPiece
//
//  Created by HanaHan on 2021/03/15.
//

import Foundation

struct Constants {
    static let DEV_BASE_URL = "https://dev.maekuswant.shop/"
    static let BASE_URL = "https://prod.maekuswant.shop/"
    
    let USERDEFAULT_KEY_CURRENT_TIMER_TIME = "savedTimeInt"
    // jwtToken은 추후 userDefualt에 저장한 값을 불러오는 것으로 수정 필요
    let testAccessTokenHeader: [String : String] = ["Content-Type": "application/json", "x-access-token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTksImlhdCI6MTYxNjExODA1MCwiZXhwIjoxNjQ3NjU0MDUwLCJzdWIiOiJ1c2VySW5mbyJ9.3MUlZisCd5vqohXDYzwt74zNvzGUnZrTrGtSQXCPlxY"]
}
