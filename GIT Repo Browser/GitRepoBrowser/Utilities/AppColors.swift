//
//  AppColors.swift
//  Git Repo Browser
//
//  Created by Karthik Kumar on 05/04/18.
//  Copyright © 2018 Karthik Kumar. All rights reserved.
//

import UIKit

enum AppColors {
    case theme
    case cellBackgroundWiki
    case cellBackgroundNonWiki
    case lightText
    case darkText
    case none
    
    func getColor() -> UIColor {
        switch self {
        case .theme:
            return UIColor(red: 33/255, green: 33/255, blue: 44/255, alpha: 1.0)
        case .cellBackgroundWiki:
            return #colorLiteral(red: 0.1876354636, green: 0.7112944162, blue: 0, alpha: 1)
        case .cellBackgroundNonWiki:
            return #colorLiteral(red: 0.7112944162, green: 0, blue: 0.03326925817, alpha: 1)
        case .lightText:
            return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        case .darkText:
            return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        default:
            return UIColor.white
        }
    }
}
