//
//  APIClient.swift
//  Git Repo Browser
//
//  Created by Karthik Kumar on 06/04/18.
//  Copyright © 2018 Karthik Kumar. All rights reserved.
//

import Foundation

protocol APIClient {
    var session: URLSession { get }
    
    func fetch<T: Decodable>(with request: URLRequest,
                             decode: @escaping (Decodable) -> T?,
                             completion: @escaping (Result <T, APIError>) -> Void)
}


extension APIClient {
    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void
    
    // parse or decode JSON data
    private func decodingTask<T: Decodable>(with request: URLRequest,
                                            decodingType: T.Type,
                                            completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .iso8601
                        let genericModel = try decoder.decode(decodingType, from: data)
                        completion(genericModel, nil)
                    } catch let err {
                        print(err)
                        completion(nil, .jsonConversionFailed)
                    }
                } else {
                    completion(nil, .invalidData)
                }
            } else {
                completion(nil, .responseUnsuccessful)
            }
        }
        
        return task
    }
    
    func fetch<T: Decodable>(with request: URLRequest,
                             decode: @escaping (Decodable) -> T?,
                             completion: @escaping (Result<T, APIError>) -> Void) {
        let task = decodingTask(with: request, decodingType: T.self) { (json, error) in
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(Result.failure(error))
                    } else {
                        completion(Result.failure(.invalidData))
                    }
                    
                    return
                }
                
                if let value = decode(json) {
                    completion(Result.success(value))
                } else {
                    completion(Result.failure(.jsonParsingFailed))
                }
            }
        }
        
        task.resume()
    }
}
