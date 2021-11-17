//
//  ApisSuffix.swift
//  Copyright © 2020 All rights reserved.
//

import Foundation

enum APISuffix {
    
    case userListing
    
    func getDescription() -> String {
        
        switch self {
        case .userListing:
            return "api/users"
            
    }
}
}

enum Urls {
    case baseUrl

    func getDescription()-> String{
        switch self {
        case .baseUrl :
            return "https://reqres.in/"
        
        }
    }
}

