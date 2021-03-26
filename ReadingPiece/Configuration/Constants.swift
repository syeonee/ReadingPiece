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
    let USERDEFAULT_KEY_CURRENT_TIMER_TIME = "savedTimeInt"
    let USERDEFAULT_KEY_GOAL_ID = "goalId"
    let ACCESS_TOKEN_HEADER: [String : String] = ["Content-Type": "application/json", "x-access-token": KEYCHAIN_TOKEN ?? ""]
}
