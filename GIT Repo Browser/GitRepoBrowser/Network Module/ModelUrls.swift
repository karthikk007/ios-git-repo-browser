//
//  ModelUrls.swift
//  Git Repo Browser
//
//  Created by Karthik Kumar on 10/04/18.
//  Copyright © 2018 Karthik Kumar. All rights reserved.
//

import Foundation

enum ModelAPI {
    case repos
    case ownerDetail(String)
}

extension ModelAPI: EndPoint {
    var base: String {
        
        switch self {
        case .repos:
            return "https://api.github.com/users/karthikk007/repos"
        case .ownerDetail(let url):
            return url
        }
        
//        return "https://api.github.com"
    }
    
    var path: String? {
//        switch self {
//        case .repos:
//            return "/users/here/repos"
//        }
        return nil
    }
}
