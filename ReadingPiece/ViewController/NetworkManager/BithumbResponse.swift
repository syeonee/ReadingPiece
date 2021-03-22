//
//  UserResponse.swift
//  NetworkLayer
//
//  Created by AHMET KAZIM GUNAY on 29/10/2017.
//  Copyright © 2017 AHMET KAZIM GUNAY. All rights reserved.
//

import Foundation

public struct BithumbResponse: Codable {
    public let status: String?
    public let data: BithumbData?
}

public struct BithumbData: Codable {
    public let timeStamp: String?
    public let paymentCurrency: String?

    enum CodingKeys: String, CodingKey {
        case timeStamp = "timestamp"
        case paymentCurrency = "payment_currency"
    }
}

public struct Coins: Codable {
    public let orderCurrency: String
    public let bids: Coin
    public let asks: Coin

    enum CodingKeys: String, CodingKey {
        case orderCurrency = "order_currency"
        case bids = "bids"
        case asks = "asks"
    }
}

public struct Coin: Codable {
    public let quantity: String
    public let price: String

}
