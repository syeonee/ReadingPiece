//
//  File.swift
//  ReadingPiece
//
//  Created by HanaHan on 2021/04/20.
//

import Foundation

struct Cake {
    enum Types {
        case blueberryCake
        case chocoCake
        case strawberryCake
        
        var name: String{
            switch self {
            case .blueberryCake : return "blueberryCake"
            case .chocoCake : return "chocoCake"
            case .strawberryCake : return "strawberryCake"
            }
        }
    }
}
