//
//  EditProfileRequest.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/03/24.
//

import Foundation

final class EditProfileRequest: Requestable {
    typealias ResponseType = EditProfileResponse
    
    private var name: String
    private var profileImage: String
    private var resolution: String
    
    init(name: String, profileImage: String, resolution: String) {
        self.name = name
        self.profileImage = profileImage
        self.resolution = resolution
    }
    
    var baseUrl: URL {
        return  URL(string: Constants.DEV_BASE_URL)!
    }
    
    var endpoint: String {
        return "profile"
    }
    
    var method: Network.Method {
        return .post
    }
    
    var query: Network.QueryType {
        return .json
    }
    
    var parameters: [String : Any]? {
        return ["name": self.name,"profilePictureURL": self.profileImage, "vow":self.resolution]
    }
    
    var headers: [String : String]? {
        return Constants().testAccessTokenHeader
    }
    
    var timeout: TimeInterval {
        return 5.0
    }
    
    var cachePolicy: NSURLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }
}