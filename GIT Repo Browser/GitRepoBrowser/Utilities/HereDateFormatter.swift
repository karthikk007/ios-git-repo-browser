//
//  HereDateFormatter.swift
//  Git Repo Browser
//
//  Created by Karthik Kumar on 11/04/18.
//  Copyright © 2018 Karthik Kumar. All rights reserved.
//

import Foundation

class HereDateFormatter {
    
    private let dateFormatter: DateFormatter
    
    static let shared = HereDateFormatter()
    
    private init() {
        dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale(identifier: "en_US")
    }
    
    func getFormattedString(from date: Date) -> String {
        return dateFormatter.string(from: date)
    }
}
