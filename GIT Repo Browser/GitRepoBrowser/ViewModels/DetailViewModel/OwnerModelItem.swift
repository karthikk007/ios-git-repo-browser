//
//  OwnerModelItem.swift
//  Git Repo Browser
//
//  Created by Karthik Kumar on 11/04/18.
//  Copyright © 2018 Karthik Kumar. All rights reserved.
//

import Foundation

enum OwnerModelItemAttributeList: String {
    case image, name, blog, email
    
    var description: String {
        switch self {
        case .image:
            return "Image"
        case .name:
            return "Name"
        case .blog:
            return "Blog"
        case .email:
            return "E-Mail"
        }
    }
}

extension OwnerModelItemAttributeList {
    static let allValues = [image, name, blog, email]
    
    func getValue(from data: DetailOwnerModel) -> String? {
        switch self {
        case .image:
            return data.avatarUrl
        case .name:
            return data.name
        case .blog:
            return data.blog
        case .email:
            return data.email ?? "null"
        }
    }
}

struct OwnerModelItem: DetailViewModelItem {
    var type: DetailViewItemType {
        return .owner(nil)
    }
    
    var sectionTitle: String {
        return type.description
    }
    
    var rowCount: Int {
        return attributes.count
    }
    
    var attributes: [ItemAttributes]
    
    init(attributes: [ItemAttributes]) {
        self.attributes = attributes
    }
}
