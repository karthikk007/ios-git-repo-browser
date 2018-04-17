//
//  DetailOwnerModelClient.swift
//  Git Repo Browser
//
//  Created by Karthik Kumar on 11/04/18.
//  Copyright © 2018 Karthik Kumar. All rights reserved.
//

import Foundation

class DetailOwnerModelClient: APIClient {
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func fetch(from endPoint: EndPoint,
               completion: @escaping (Result<DetailOwnerModel?, APIError>) -> Void) {
        
        fetch(with: endPoint.request, decode: { (json) -> DetailOwnerModel? in
            guard let reposModelResult = json as? DetailOwnerModel else {
                return nil
            }
            
            return reposModelResult
        }, completion: completion)
    }
}
