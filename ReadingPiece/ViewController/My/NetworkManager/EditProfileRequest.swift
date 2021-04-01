//
//  EditProfileRequest.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/03/24.
//

import Foundation

final class EditProfileRequest: Requestable {
    typealias ResponseType = EditProfileResponse
    
    private var token: String
    private var name: String
    private var profileImage: String?
    private var resolution: String
    
    init(token: String, name: String, profileImage: String?, resolution: String) {
        self.token = token
        self.name = name
        if let profile = profileImage {
            self.profileImage = profile
        }else{
            self.profileImage = nil
        }
        self.resolution = resolution
    }
    
    var baseUrl: URL {
        return  URL(string: Constants.BASE_URL)!
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
        return ["name": self.name, "profilePictureURL": self.profileImage, "vow":self.resolution]
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json", "x-access-token": self.token]
    }
    
    var timeout: TimeInterval {
        return 10.0
    }
    
    var cachePolicy: NSURLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }
}
