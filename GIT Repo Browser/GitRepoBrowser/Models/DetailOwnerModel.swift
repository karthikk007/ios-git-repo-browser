//
//  DetailOwnerModel.swift
//  Git Repo Browser
//
//  Created by Karthik Kumar on 11/04/18.
//  Copyright © 2018 Karthik Kumar. All rights reserved.
//

import Foundation

struct DetailOwnerModel: Codable {
    let login: String?
    let id: Int?
    let avatarUrl: String?
    let url: String?
    let type: String?
    let name: String?
    let company: String?
    let blog: String?
    let email: String?
    let createdAt: Date?
    let updatedAt: Date?
    
    private enum CodingKeys: String, CodingKey {
        case login
        case id
        case avatarUrl = "avatar_url"
        case url
        case type
        case name
        case company
        case email
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case blog
    }
}
