//
//  SortOptions.swift
//  Git Repo Browser
//
//  Created by Karthik Kumar on 10/04/18.
//  Copyright © 2018 Karthik Kumar. All rights reserved.
//

import Foundation

typealias SortComparator = (ReposModel, ReposModel) -> Bool

enum SortOption: CustomStringConvertible {
    
    enum dateComparatorType: Int {
        case createdAt, updatedAt, pushedAt
        
        func getDate(a: ReposModel, b: ReposModel) -> (Date, Date) {
            let date_: Date?, _date: Date?
            
            switch self {
            case .createdAt:
                date_ = a.createdAt
                _date = b.createdAt
            case .pushedAt:
                date_ = a.pushedAt
                _date = b.pushedAt
            case .updatedAt:
                date_ = a.updatedAt
                _date = b.updatedAt
            }
            
            return (date_!, _date!)
        }
    }
    
    enum SortType: Int, CustomStringConvertible {
        case asc, desc
        
        init?(withString: String) {
            switch withString {
            case let string where string.contains("asc"):
                self = .asc
            case let string where string.contains("desc"):
                self = .desc
            default:
                return nil
            }
        }
        
        var description: String {
            switch self {
            case .asc:
                return "asc"
            case .desc:
                return "desc"
            }
        }
    }
    
    case name(SortType)
    case createdDate(SortType)
    case updatedDate(SortType)
    case pushedDate(SortType)
    
    init?(withString: String) {
        
        guard let type = SortType(withString: withString) else {
            return nil
        }
        switch withString {
        case let string where string.contains("NAME"):
            self = .name(type)
        case let string where string.contains("CREATED DATE"):
            self = .createdDate(type)
        case let string where string.contains("UPDATED DATE"):
            self = .updatedDate(type)
        case let string where string.contains("PUSHED DATE"):
            self = .pushedDate(type)
        default:
            return nil
        }
    }
    
    var description: String {
        switch self {
        case .name(let type):
            return "NAME " + String(describing: type)
        case .createdDate(let type):
            return "CREATED DATE " + String(describing: type)
        case .updatedDate(let type):
            return "UPDATED DATE " + String(describing: type)
        case .pushedDate(let type):
            return "PUSHED DATE " + String(describing: type)
        }
    }
}

extension SortOption {
    func getComparator() -> SortComparator {
        switch self {
        case .name(let type):
            return nameCompatator(sortType: type)
        case .createdDate(let type):
            return dateComparator(sortType: type, dateType: .createdAt)
        case .updatedDate(let type):
            return dateComparator(sortType: type, dateType: .updatedAt)
        case .pushedDate(let type):
            return dateComparator(sortType: type, dateType: .pushedAt)
        }
    }
    
    private func nameCompatator(sortType: SortType) -> SortComparator {
        
        let block: SortComparator
        
        switch sortType {
        case .asc:
            block = { (a: ReposModel, b: ReposModel) -> Bool in
                
                guard let aName = a.fullName?.lowercased(), let bName = b.fullName?.lowercased() else {
                    return false
                }
                
                //return aName > bna
                
                switch aName.compare(bName) {
                case .orderedSame:
                    return false
                case .orderedAscending:
                    return true
                case .orderedDescending:
                    return false
                }
            }
        case .desc:
            block = { (a: ReposModel, b: ReposModel) -> Bool in
                
                guard let aName = a.fullName?.lowercased(), let bName = b.fullName?.lowercased() else {
                    return false
                }
                
                switch aName.compare(bName) {
                case .orderedSame:
                    return false
                case .orderedAscending:
                    return false
                case .orderedDescending:
                    return true
                }
            }
        }
        
        return block
    }
    
    func dateComparator(sortType: SortType, dateType: dateComparatorType) -> SortComparator {
        let block: SortComparator
        
        switch sortType {
        case .asc:
            block = { (a: ReposModel, b: ReposModel) -> Bool in
                
                let date = dateType.getDate(a: a, b: b)
                
                return date.0 < date.1
            }
        case .desc:
            block = { (a: ReposModel, b: ReposModel) -> Bool in
                
                let date = dateType.getDate(a: a, b: b)
                
                return date.0 > date.1
            }
        }
        
        return block
    }
}

extension SortOption: Hashable {
    
    var hashValue: Int {
        let primeConstant: Int = 16777619
        
        switch self {
        case .name(let type):
            return type.hashValue &* primeConstant
        case .createdDate(let type):
            return type.hashValue &* primeConstant
        case .updatedDate(let type):
            return type.hashValue &* primeConstant
        case .pushedDate(let type):
            return type.hashValue &* primeConstant
        }
    }
    
    static func == (lhs: SortOption, rhs: SortOption) -> Bool {
        switch (lhs, rhs) {
        case let (.name(type_), .name(_type)):
            return type_ == _type
        case let (.createdDate(type_), .createdDate(_type)):
            return type_ == _type
        case let (.updatedDate(type_), .updatedDate(_type)):
            return type_ == _type
        case let (.pushedDate(type_), .pushedDate(_type)):
            return type_ == _type
        default:
            return false
        }
    }
    
    static let allValues = [name(.asc), name(.desc),
                            createdDate(.asc), createdDate(.desc),
                            updatedDate(.asc), updatedDate(.desc),
                            pushedDate(.asc), pushedDate(.desc)
                            ]
}
