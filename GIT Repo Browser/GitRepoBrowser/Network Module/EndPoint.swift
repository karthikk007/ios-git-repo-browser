//
//  EndPoint.swift
//  Git Repo Browser
//
//  Created by Karthik Kumar on 06/04/18.
//  Copyright © 2018 Karthik Kumar. All rights reserved.
//

import Foundation

protocol EndPoint {
    var base: String { get }
    var path: String? { get }
}

extension EndPoint {
    var apiKey: String {
        return ""
    }
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        if let path = path {
            components.path = path
        }
        components.query = apiKey
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }
}
