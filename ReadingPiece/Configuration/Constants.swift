//
//  Constants.swift
//  ReadingPiece
//
//  Created by HanaHan on 2021/03/15.
//

import Foundation
import KeychainSwift

struct Constants {
    static let KEYCHAIN_TOKEN = KeychainSwift(keyPrefix: Keys.keyPrefix).get(Keys.token)
    static let DEV_BASE_URL = "https://dev.maekuswant.shop/"
    static let BASE_URL = "https://prod.maekuswant.shop/"
    let keychain = KeychainSwift(keyPrefix: Keys.keyPrefix)
    let USERDEFAULT_KEY_CURRENT_TIMER_TIME = "savedTimeInt"
    let USERDEFAULT_KEY_GOAL_ID = "goalId"
    // jwtToken은 추후 userDefualt에 저장한 값을 불러오는 것으로 수정 필요
    let testAccessTokenHeader: [String : String] = ["Content-Type": "application/json", "x-access-token": KEYCHAIN_TOKEN ?? ""]
}
