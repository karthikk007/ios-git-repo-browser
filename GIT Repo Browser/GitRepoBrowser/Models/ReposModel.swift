//
//  ReposModel.swift
//  Git Repo Browser
//
//  Created by Karthik Kumar on 05/04/18.
//  Copyright © 2018 Karthik Kumar. All rights reserved.
//

import Foundation

struct ReposModel: Codable {
    
    let id: Int?
    let name: String?
    let fullName: String?
    let owner: Owner?
    let isPrivate: Bool?
    let description: String?
    let isFork: Bool?
    let createdAt: Date?
    let updatedAt: Date?
    let pushedAt: Date?
    let language: String?
    let hasWiki: Bool?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case owner
        case isPrivate = "private"
        case description
        case isFork = "fork"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pushedAt = "pushed_at"
        case language
        case hasWiki = "has_wiki"
    }
}



