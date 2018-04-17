//
//  DetailViewModel.swift
//  Git Repo Browser
//
//  Created by Karthik Kumar on 11/04/18.
//  Copyright © 2018 Karthik Kumar. All rights reserved.
//

import UIKit

// MARK: - DetailViewModelDataSource methods
protocol DetailViewModelDataSource {
    func refreshData()
    func numberOfSections() -> Int
    func numberOfRows(for section: Int) -> Int
    func getTitle() -> String?
    func getTitle(for section: Int) -> String?
    func getModel(for indexPath: IndexPath) -> ItemAttributes
    func heightFor(rowAt indexPath: IndexPath) -> CGFloat
}

// MARK: - DetailViewModelDelegate event methods
protocol DetailViewModelDelegate {
    func didFinishFetchingWithError()
    func didFinishFetchingData()
    func willFetchData()
}

// MARK: - DetailViewModelFactory
class DetailViewModelFactory {
    class func getViewModel(repoModel: ReposModel, delegate: DetailViewModelDelegate) -> DetailViewModelDataSource {
        let vm = DetailViewModel(repoModel: repoModel, delegate: delegate)
        return vm
    }
}

// MARK: - DetailViewModel
fileprivate class DetailViewModel {
    
    private let delegate: DetailViewModelDelegate
    
    private var repoModel: ReposModel
    private var ownerDetails: DetailOwnerModelResult
    
    private var items: [DetailViewModelItem]
    
    init(repoModel: ReposModel, delegate: DetailViewModelDelegate) {
        self.delegate = delegate
        self.repoModel = repoModel
        self.items = [DetailViewModelItem]()
        self.ownerDetails = DetailOwnerModelResult()
        
        ownerDetails.delegate = self
    }
    
    private func populateItems() {
        var sections = [DetailViewModelItem]()
        
        var sectionType = [DetailViewItemType]()
        
        for section in DetailViewItemType.allValues {
            
            switch section {
            case .details(_):
                sectionType.append(DetailViewItemType.details(repoModel))
            case .owner(_):
                sectionType.append(DetailViewItemType.owner(nil))
            }
        }
        
        for section in sectionType {
            let item = section.getSection()
            sections.append(item)
        }

        items = sections
        fetchOwnerDetails()
    }
    
    private func fetchOwnerDetails() {
        delegate.willFetchData()
        if let url = repoModel.owner?.url {
            ownerDetails.load(url: url)
        } else {
            let section = DetailViewItemType.owner(nil)
            items.remove(at: section.getPosition())
            delegate.didFinishFetchingData()
        }
    }
    
    private func addOwnerSection() {
        if let data = ownerDetails.results {
            let section = DetailViewItemType.owner(data)
            
            let sectionItem = section.getSection()
            
            if items.count > section.getPosition() {
                items.remove(at: section.getPosition())
            }
            
            items.insert(sectionItem, at: section.getPosition())
            
        } else {
            let section = DetailViewItemType.owner(nil)
            items.remove(at: section.getPosition())
        }
        
        delegate.didFinishFetchingData()
    }
    
}

extension DetailViewModel: DetailOwnerModelResultDelegate {
    func loaded() {
        addOwnerSection()
    }
}

extension DetailViewModel: DetailViewModelDataSource {
    
    func refreshData() {
        populateItems()
    }
    
    func numberOfSections() -> Int {
        return items.count
    }
    
    func numberOfRows(for section: Int) -> Int {
        return items[section].rowCount
    }
    
    func getModel(for indexPath: IndexPath) -> ItemAttributes {
        var data: ItemAttributes = ItemAttributes(key: "", value: "")
        
        let item = items[indexPath.section]
        
        switch item.type {
        case .details(_):
            if let item = item as? DetailModelItem {
                data = item.attributes[indexPath.row]
            }
        case .owner(_):
            if let item = item as? OwnerModelItem {
                data = item.attributes[indexPath.row]
            }
        }
        
        return data
    }
    
    func getTitle() -> String? {
        return repoModel.name
    }
    
    func getTitle(for section: Int) -> String? {
        return items[section].sectionTitle
    }
    
    func heightFor(rowAt indexPath: IndexPath) -> CGFloat {
        let attribute = getModel(for: indexPath)
        
        if attribute.key == OwnerModelItemAttributeList.image.description {
            return 300
        } else {
            return attribute.estimatedHeight().height
        }
    }
}
