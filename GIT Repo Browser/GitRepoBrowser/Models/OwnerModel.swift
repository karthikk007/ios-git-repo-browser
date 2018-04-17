//
//  OwnerModel.swift
//  Git Repo Browser
//
//  Created by Karthik Kumar on 05/04/18.
//  Copyright © 2018 Karthik Kumar. All rights reserved.
//

import Foundation

struct Owner: Codable {
    let login: String?
    let id: Int?
    let avatarUrl: String?
    let url: String?
    let type: String?
    
    private enum CodingKeys: String, CodingKey {
        case login
        case id
        case avatarUrl = "avatar_url"
        case url
        case type
    }
}
