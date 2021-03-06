//
//  ReposModelResult.swift
//  Git Repo Browser
//
//  Created by Karthik Kumar on 06/04/18.
//  Copyright © 2018 Karthik Kumar. All rights reserved.
//

import Foundation

protocol ReposModelResultDelegate {
    func loaded()
}

class ReposModelResult {
    var results: [ReposModel]?
    
    var delegate: ReposModelResultDelegate?
    
    let defaultUser: String = "karthikk007"
    private var user: String!
    
    func load() {
        let client = ReposModelClient()
                
        let endPoint = ModelAPI.repos(user)
        
        client.fetch(from: endPoint) { (result) in
            switch result {
            case .success(let data):
                guard let results = data else {
                    return
                }
                self.results = results
            case .failure(let error):
                print("the error \(error)")
            }
            self.delegate?.loaded()
        }
    }
    
    func clear() {
        results?.removeAll()
    }
    
    func setUser(user: String) {
        if user == "" {
            self.user = defaultUser
        } else {
            self.user = user
        }
    }
}
