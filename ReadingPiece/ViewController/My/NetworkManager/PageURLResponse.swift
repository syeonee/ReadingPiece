//
//  PageURLResponse.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/05/06.
//

import Foundation

public struct PageURLResponse: Codable {
    public let isSuccess: Bool
    public let code: Int
    public let message: String
    public let uriInfo: [UriInfo]
    
    enum CodingKeys: String, CodingKey {
        case isSuccess
        case code
        case message
        case uriInfo = "result"
    }
}

public struct UriInfo: Codable {
    public let uriId: Int
    public let uri: String
    public let uriTitle: String
}
