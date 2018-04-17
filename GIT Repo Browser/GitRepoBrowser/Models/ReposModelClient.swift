//
//  ReposModelClient.swift
//  Git Repo Browser
//
//  Created by Karthik Kumar on 06/04/18.
//  Copyright © 2018 Karthik Kumar. All rights reserved.
//

import Foundation

class ReposModelClient: APIClient {
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func fetch(from endPoint: EndPoint,
               completion: @escaping (Result<[ReposModel]?, APIError>) -> Void) {
        
        fetch(with: endPoint.request, decode: { (json) -> [ReposModel]? in
            guard let reposModelResult = json as? [ReposModel] else {
                return nil
            }
            
            return reposModelResult
        }, completion: completion)
    }
}
