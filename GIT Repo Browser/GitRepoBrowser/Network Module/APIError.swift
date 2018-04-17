//
//  APIError.swift
//  Git Repo Browser
//
//  Created by Karthik Kumar on 06/04/18.
//  Copyright © 2018 Karthik Kumar. All rights reserved.
//

import Foundation

enum APIError: Error {
    case requestFailed
    case jsonConversionFailed
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailed
    
    var localizedDescription: String {
        switch self {
        case .requestFailed:
            return "Request Failed"
        case .jsonConversionFailed:
            return "JSON Conversion Failed"
        case .invalidData:
            return "Invalid Data"
        case .responseUnsuccessful:
            return "Response Unsuccessful"
        case .jsonParsingFailed:
            return "JSON Parsing Failed"
        }
    }
}
