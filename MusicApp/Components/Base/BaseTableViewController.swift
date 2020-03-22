//
//  BaseTableViewController.swift
//  Tipbros
//
//  Created by Henry Tran on 11/25/19.
//  Copyright © 2019 Vinova. All rights reserved.
//

import UIKit
import SVProgressHUD

let limit = 10

class BaseTableViewController: BaseViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    
    var listItem: [Any] = [] {
        didSet {
            SVProgressHUD.dismiss()
            print("* list tableview item count = \(self.listItem.count) *")
            DispatchQueue.main.async {
                self.myTableView.isHidden = false
                self.myTableView.reloadData()
            }
        }
    }
    let refreshControl = UIRefreshControl()
    var canLoadMore = false
    var showLoadingIcon = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addPullToRefresh()
        
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.showsVerticalScrollIndicator = false

    }
    
    // MARK: - Fetch data from API
    func fetchData() {
        if showLoadingIcon {
            SVProgressHUD.show()
        }
    }
    
    func didFetchData(data: [Any]) {
        
        // Check can load more
        if data.count < limit {
            canLoadMore = false
        } else {
            canLoadMore = true
        }
        // Store data
        if listItem.count == 0 {
            listItem = data
        } else {
            listItem += data
        }
        /** Show no data if need
            ...
        */
        
    }
    
    // MARK: - For pull to refresh
    private func addPullToRefresh() {
//        refreshControl.tintColor = UIc
        refreshControl.addTarget(self, action: #selector(BaseTableViewController.pullToRefresh), for: .valueChanged)
        if #available(iOS 10.0, *) {
            self.myTableView.refreshControl = refreshControl
        } else {
            self.myTableView.addSubview(refreshControl)
        }
    }
    
    @objc func pullToRefresh() {
        self.listItem.removeAll()
        canLoadMore = true
        showLoadingIcon = false
        fetchData()
        refreshControl.endRefreshing()
    }
    
    
    // MARK:- Override to use
    func cellForRowAt(item: Any, for indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        /** Do something
            ...
        */
        return UITableViewCell()
    }
    
    func didSelectRowAt(selectedItem: Any, indexPath: IndexPath) {
        /** Do something
            ...
        */
    }
    
    func setHeightForRow() -> CGFloat {
        let height: CGFloat = UITableView.automaticDimension
        return height
    }
}

// MARK: - Table view delegate
extension BaseTableViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return setHeightForRow()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRowAt(selectedItem: listItem[indexPath.row], indexPath: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == listItem.count - 1 && canLoadMore {
            self.showLoadingIcon = false
            let spiner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.white)
            spiner.startAnimating()
            spiner.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 44)
            tableView.tableFooterView = spiner
            tableView.tableFooterView?.isHidden = false
            // -----
            print("* loadmore *")
            fetchData()
        } else {
            tableView.tableFooterView = nil
            tableView.tableFooterView?.isHidden = true
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        dismissKeyBoard()
    }
    
}

// MARK: - Table view datasource
extension BaseTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellForRowAt(item: listItem[indexPath.row], for: indexPath, tableView: tableView)
    }
}
