//
//  Result.swift
//  Git Repo Browser
//
//  Created by Karthik Kumar on 06/04/18.
//  Copyright © 2018 Karthik Kumar. All rights reserved.
//

import Foundation

enum Result<T, U> where U: Error {
    case success(T)
    case failure(U)
}




