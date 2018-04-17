//
//  DetailModelItem.swift
//  Git Repo Browser
//
//  Created by Karthik Kumar on 11/04/18.
//  Copyright © 2018 Karthik Kumar. All rights reserved.
//

import Foundation


enum DetailModelItemAttributeList: String {
    case name, description, languages, isFork, lastUpdated
}

extension DetailModelItemAttributeList {
    static let allValues = [name, description, languages, isFork, lastUpdated]
    
    func getValue(from data: ReposModel) -> String? {
        switch self {
        case .name:
            return data.name
        case .description:
            return data.description
        case .languages:
            return data.language
        case .isFork:
            if let fork = data.isFork {
                return fork ? "TRUE" : "FALSE"
            }
            
            return "FALSE"
        case .lastUpdated:
            
            if let date = data.updatedAt {
                return HereDateFormatter.shared.getFormattedString(from: date)
            }
            
            return ""
        }
    }
    
    var description: String {
        switch self {
        case .name:
            return "Name"
        case .description:
            return "Description"
        case .languages:
            return "Languages"
        case .isFork:
            return "Forked?"
        case .lastUpdated:
            return "Last Updated"
        }
    }
}

struct DetailModelItem: DetailViewModelItem {
    var type: DetailViewItemType {
        return .details(nil)
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
