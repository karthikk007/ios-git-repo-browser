//
//  DetailOwnerModelResult.swift
//  Git Repo Browser
//
//  Created by Karthik Kumar on 11/04/18.
//  Copyright © 2018 Karthik Kumar. All rights reserved.
//

import Foundation


protocol DetailOwnerModelResultDelegate {
    func loaded()
}

class DetailOwnerModelResult {
    var results: DetailOwnerModel?
    
    var delegate: DetailOwnerModelResultDelegate?
    
    func load(url: String) {
        let client = DetailOwnerModelClient()
        let endPoint = ModelAPI.ownerDetail(url)
                
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
}
