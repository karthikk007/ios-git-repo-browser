//
//  MainViewModel.swift
//  Git Repo Browser
//
//  Created by Karthik Kumar on 09/04/18.
//  Copyright © 2018 Karthik Kumar. All rights reserved.
//

import Foundation

protocol MainTableViewControllerDataSource: class {
    func refreshData()
    func numberOfSections() -> Int
    func numberOfRows() -> Int
    func getModel(for indexPath: IndexPath) -> ReposModel?
    func getSortOptions() -> [SortOption]
    func getCurrentSortType() -> SortOption
}



protocol MainViewModelDelegate: class {
    func didFinishFetchingWithError()
    func didFinishFetchingData()
    func willFetchData()
}


class MainViewModelFactory {
    class func getViewModel(delegate: MainViewModelDelegate) -> MainTableViewControllerDataSource {
        let vm = MainViewModel(delegate: delegate)
        return vm
    }
}

fileprivate class MainViewModel {
    
    private let delegate: MainViewModelDelegate
    
    private var reposResult: ReposModelResult
    
    private var currentSortType: SortOption {
        didSet {
            sortModels()
        }
    }
    
    init(delegate: MainViewModelDelegate) {
        self.delegate = delegate
        self.currentSortType = .updatedDate(.desc)
        
        self.reposResult = ReposModelResult()
        reposResult.delegate = self
    }
    
    private func fetchRepos() {
        notifyWillFetch()
        reposResult.load()
    }
    
    private func notifyWillFetch() {
        delegate.willFetchData()
    }
    
    private func notifyDidFetch() {
        delegate.didFinishFetchingData()
    }
    
    private func notifyDidFetchWithError() {
        delegate.didFinishFetchingWithError()
    }
    
    private func sortModels() {
        
        guard let results = reposResult.results, results.count > 0 else {
            notifyDidFetchWithError()
            return
        }
        
        reposResult.results!.sort(by: self.currentSortType.getComparator())
        notifyDidFetch()
    }
    
    private func updateCurrentSortType(sortBy: SortOption) {
        guard currentSortType != sortBy else {
            return
        }
        
        notifyWillFetch()
        currentSortType = sortBy
    }
    
}

extension MainViewModel: MainTableViewControllerDataSource {
    func refreshData() {
        fetchRepos()
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows() -> Int {
        return reposResult.results?.count ?? 0
    }
    
    func getModel(for indexPath: IndexPath) -> ReposModel? {
        
        guard let results = reposResult.results, results.count > 0, results.count > indexPath.row else {
            return  nil
        }
        
        return results[indexPath.row]
    }

    func getSortOptions() -> [SortOption] {
        return SortOption.allValues
    }
    
    func getCurrentSortType() -> SortOption {
        return currentSortType
    }
}

extension MainViewModel: ReposModelResultDelegate {
    func loaded() {
        sortModels()
    }
}

extension MainViewModel: MainTableViewControllerEventsDelegate {
    func didChangeSortType(type: SortOption) {
        updateCurrentSortType(sortBy: type)
    }
}
