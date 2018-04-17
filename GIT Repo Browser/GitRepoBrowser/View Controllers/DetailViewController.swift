//
//  DetailViewController.swift
//  Git Repo Browser
//
//  Created by Karthik Kumar on 05/04/18.
//  Copyright © 2018 Karthik Kumar. All rights reserved.
//

import UIKit

// MARK: - class DetailViewController
class DetailViewController: UITableViewController {
    
    // MARK: - member variables
    var dataSource: DetailViewModelDataSource!
    
    private var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
    
    // MARK: - life cycle methods
    override func loadView() {
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = dataSource.getTitle()
        
        setupTableView()
        setupActivityIndicator()
        
        dataSource.refreshData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - helper methods
    func showError() {
        let alert = UIAlertController(title: "Error", message: "Please check your Internet connection", preferredStyle: .alert)
        
        let retryAction = UIAlertAction(title: "Retry", style: .default) { (action) in
            self.dataSource.refreshData()
        }
        
        alert.addAction(retryAction)
        
        present(alert, animated: true, completion: nil)
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

        tableView.register(InfoCell.self, forCellReuseIdentifier: InfoCell.identifier)
        tableView.register(ImageCell.self, forCellReuseIdentifier: ImageCell.identifier)
    }
    

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return dataSource.numberOfSections()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataSource.numberOfRows(for: section)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = dataSource.getModel(for: indexPath)
        let cell: UITableViewCell
        
        if data.key == OwnerModelItemAttributeList.image.description {
            let imageCell = tableView.dequeueReusableCell(withIdentifier: ImageCell.identifier, for: indexPath) as! ImageCell
            imageCell.configure(data: data)
            cell = imageCell
        } else {
            let infoCell = tableView.dequeueReusableCell(withIdentifier: InfoCell.identifier, for: indexPath) as! InfoCell
            infoCell.configure(data: data)
            cell = infoCell
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataSource.getTitle(for: section)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return max(dataSource.heightFor(rowAt: indexPath) + 30, 60)
    }

}

extension DetailViewController: DetailViewModelDelegate {
    func didFinishFetchingWithError() {
        stopActivityIndicator()
        showError()
    }
    
    func didFinishFetchingData() {
        stopActivityIndicator()
        tableView.reloadData()
    }
    
    func willFetchData() {
        startActivityIndicator()
    }
}
