//
//  String.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/25.
//

import Foundation

extension String {
    enum ValidityType {
        case email
        case password
    }
    
    enum Regex: String {
        case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0.-]+\\.[A-Za-z]{2,64}"
        case password = "[A-Z0-9a-z._%+-]{6,20}"
    }
    
    func isValid(_ validityType: ValidityType) -> Bool{
        let format = "SELF MATCHES %@"
        var regex = ""
        
        switch validityType {
        case .email:
            regex = Regex.email.rawValue
        case .password:
            regex = Regex.password.rawValue
        }
        return NSPredicate(format: format, regex).evaluate(with: self)
    }
    
    
}
