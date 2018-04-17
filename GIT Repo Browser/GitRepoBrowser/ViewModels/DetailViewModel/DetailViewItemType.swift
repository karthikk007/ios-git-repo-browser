//
//  DetailViewItemType.swift
//  Git Repo Browser
//
//  Created by Karthik Kumar on 11/04/18.
//  Copyright © 2018 Karthik Kumar. All rights reserved.
//

import Foundation

enum DetailViewItemType {
    case details(ReposModel?)
    case owner(DetailOwnerModel?)
    
    func getPosition() -> Int {
        switch self {
        case .details(_):
            return 0
        case .owner(_):
            return 1
        }
    }
}

extension DetailViewItemType {
    
    func getSection() -> DetailViewModelItem {
        let attributes = getAttributes()
        
        switch self {
        case .details(_):
            return DetailModelItem(attributes: attributes)
        case .owner(_):
            return OwnerModelItem(attributes: attributes)
        }
    }
    
    private func getAttributes() -> [ItemAttributes] {
        
        switch self {
        case .details(let data):
            var attributes = [ItemAttributes]()
            if let data = data {
                let values = DetailModelItemAttributeList.allValues
                for value in values {
                    let attribute = ItemAttributes(key: value.description, value: value.getValue(from: data) ?? "")
                    attributes.append(attribute)
                }
            }
            return attributes
        case .owner(let data):
            var attributes = [ItemAttributes]()
            if let data = data {
                
                let values = OwnerModelItemAttributeList.allValues
                for value in values {
                    let attribute = ItemAttributes(key: value.description, value: value.getValue(from: data) ?? "")
                    attributes.append(attribute)
                }
            }
            return attributes
        }
    }
}

extension DetailViewItemType: Hashable {
    
    var hashValue: Int {
        let primeConstant: Int = 16777619
        
        switch self {
        case .details(_):
            return self.hashValue &* primeConstant
        case .owner(_):
            return self.hashValue &* primeConstant
        }
    }
    
    static func == (lhs: DetailViewItemType, rhs: DetailViewItemType) -> Bool {
        switch (lhs, rhs) {
        case (.details(_), .details(_)):
            return true
        case (.owner(_), .owner(_)):
            return true
        default:
            return false
        }
    }
}

extension DetailViewItemType: RawRepresentable {
    typealias RawValue = String
    
    var rawValue: RawValue {
        switch self {
        case .details:
            return "Details"
        case .owner:
            return "Owner Info"
        }
    }
    
    init?(rawValue: String) {
        switch rawValue.lowercased() {
        case "details":
            self = .details(nil)
        case "owner":
            self = .owner(nil)
        default:
            return nil
        }
    }
    

    
    var description: String {
        switch self {
        case .details:
            return "Details"
        case .owner:
            return "Owner Info"
        }
    }
    
    static let allValues: [DetailViewItemType] = [.details(nil), .owner(nil)]
    
}
