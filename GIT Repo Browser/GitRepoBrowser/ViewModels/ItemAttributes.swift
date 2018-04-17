//
//  ItemAttributes.swift
//  Git Repo Browser
//
//  Created by Karthik Kumar on 11/04/18.
//  Copyright © 2018 Karthik Kumar. All rights reserved.
//

import UIKit

struct ItemAttributes {
    var key: String
    var value: String
    
    func estimatedHeight() -> CGSize {
        return value.estimatedSize(for: UIFont.systemFont(ofSize: 16))
    }
}
