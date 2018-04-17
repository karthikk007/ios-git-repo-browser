//
//  String+Extension.swift
//  Git Repo Browser
//
//  Created by Karthik Kumar on 11/04/18.
//  Copyright © 2018 Karthik Kumar. All rights reserved.
//

import UIKit


extension String {
    
    func estimatedSize(for font: UIFont) -> CGSize {
        
        let string: NSString = NSString(string: self)
        
        let rect = string.boundingRect(with: CGSize(width: UIScreen.main.bounds.size.width, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return rect.size
    }
}

