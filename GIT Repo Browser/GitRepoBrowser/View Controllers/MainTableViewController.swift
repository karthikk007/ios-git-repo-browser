//
//  MainTableViewController.swift
//  Git Repo Browser
//
//  Created by Karthik Kumar on 05/04/18.
//  Copyright © 2018 Karthik Kumar. All rights reserved.
//

import UIKit

// MARK: - MainTableViewController event methods
protocol MainTableViewControllerEventsDelegate {
    func didChangeSortType(type: SortOption)
}

// MARK: - MainTableViewController
class MainTableViewController: UITableViewController {
    
    // MARK: - member variables
    var dataSource: MainTableViewControllerDataSource!
    
    private var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
    var eventsDelegate: MainTableViewControllerEventsDelegate!
    
    lazy var pullToRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()

        refreshControl.addTarget(self, action: #selector(MainTableViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)

        refreshControl.tintColor = UIColor.white
        return refreshControl
    }()
    
    // MARK: - life cycle
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func loadView() {
        super.loadView()
        
        dataSource = MainViewModelFactory.getViewModel(delegate: self)
        eventsDelegate = dataSource as! MainTableViewControllerEventsDelegate
        dataSource.refreshData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(sortButtonClicked))
        
        title = "Browser"
        
        setupTableView()
        setupActivityIndicator()
        subscribeForNotifications()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - UI event handlers
    @objc
    private func handleRefresh(_ refreshControl: UIRefreshControl) {
        dataSource.refreshData()
    }
    
    @objc
    private func sortButtonClicked(_ sender: AnyObject) {
        showActionSheet()
    }
    
    // MARK: - helper methods
    
    private func subscribeForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(MainTableViewController.applicationWillEnterForeground(_:)), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MainTableViewController.applicationDidEnterBackground(_:)), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
    }
    
    @objc
    private func applicationWillEnterForeground(_ sender: Any) {
        dataSource.refreshData()
    }
    
    @objc
    private func applicationDidEnterBackground(_ sender: Any) {
        
    }
    
    private func startActivityIndicator() {
        activityIndicator.startAnimating()
        self.tableView.isUserInteractionEnabled = false
    }
    
    private func stopActivityIndicator() {
        //        tableView.isHidden = false
        activityIndicator.stopAnimating()
        self.tableView.isUserInteractionEnabled = true
    }
    
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = view.center
    }
    
    private func setupTableView() {
        tableView.tableFooterView = UIView()
        
        tableView.register(RepoCell.self, forCellReuseIdentifier: RepoCell.identifier)
        tableView.addSubview(pullToRefreshControl)
    }
    
    private func launchDetails(indexPath: IndexPath) {
        
        if let data = dataSource.getModel(for: indexPath) {
            let vc = DetailViewController(nibName: nil, bundle: nil)
            let dataSource = DetailViewModelFactory.getViewModel(repoModel: data, delegate: vc)
            vc.dataSource = dataSource
            navigationController?.pushViewController(vc, animated: true)
        }

    }


    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return dataSource.numberOfSections()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataSource.numberOfRows()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepoCell.identifier, for: indexPath) as! RepoCell

        if let data = dataSource.getModel(for: indexPath) {
            cell.configure(data: data)
        }
        
        cell.transform = cell.transform.scaledBy(x: 0.0, y: 0.0)
        UIView.animate(withDuration: 0.2, delay: 0.1, options: UIViewAnimationOptions.curveEaseOut, animations: {
            cell.transform = .identity
        })
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        launchDetails(indexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}

// MARK: - handle actions
extension MainTableViewController {
    private func showActionSheet() {
        
        let options = dataSource.getSortOptions()
        
        let menu = UIAlertController(title: "Sort By", message: nil, preferredStyle: .actionSheet)
        
        var style = UIAlertActionStyle.default
        
        for option in options {
            
            if option == dataSource.getCurrentSortType() {
                style = .destructive
            } else {
                 style = .default
            }
            
            let action = UIAlertAction(title: option.description, style: style) { (action) in
                
                guard let title = action.title, let sortType = SortOption(withString: title) else {
                    return
                }
                
                self.eventsDelegate.didChangeSortType(type: sortType)
                
            }
            
            menu.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
        }
        
        menu.addAction(cancelAction)
        
        self.present(menu, animated: true, completion: nil)
    }
    
    func showError() {
        let alert = UIAlertController(title: "Error", message: "Please check your Internet connection", preferredStyle: .alert)
        
        let retryAction = UIAlertAction(title: "Retry", style: .default) { (action) in
            self.dataSource.refreshData()
        }
        
        alert.addAction(retryAction)
        
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - implement model delegate
extension MainTableViewController: MainViewModelDelegate {
    func didFinishFetchingData() {
        stopActivityIndicator()
        pullToRefreshControl.endRefreshing()
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
    }
    
    func didFinishFetchingWithError() {
        pullToRefreshControl.endRefreshing()
        stopActivityIndicator()
        showError()
    }
    
    func willFetchData() {
        startActivityIndicator()
    }
}
