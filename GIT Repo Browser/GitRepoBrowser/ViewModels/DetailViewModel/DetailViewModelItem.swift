//
//  DetailViewModelItem.swift
//  Git Repo Browser
//
//  Created by Karthik Kumar on 11/04/18.
//  Copyright © 2018 Karthik Kumar. All rights reserved.
//

import Foundation

protocol DetailViewModelItem {
    var type: DetailViewItemType { get }
    var sectionTitle: String { get }
    var rowCount: Int { get }
}
