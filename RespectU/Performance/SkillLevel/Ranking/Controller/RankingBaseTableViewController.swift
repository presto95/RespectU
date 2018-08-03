//
//  RankingBaseTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 3..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import RealmSwift
import FirebaseAuth
import FirebaseDatabase

class RankingBaseTableViewController: BaseTableViewController {
    
    var sortedDic = [(key: String, value: Double)]()
    let nickname = UserDefaults.standard.string(forKey: "nickname") ?? (Auth.auth().currentUser?.email)!
    let cellIdentifier = "rankingCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "RankingCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? RankingCell else { return UITableViewCell() }
        cell.setProperties(sortedDic, at: indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sortedDic.count
    }
    
    @objc func didReceiveFirebaseFetch(_ notification: Notification) {
        guard let dictionary = notification.userInfo?["dictionary"] as? [(key: String, value: Double)] else { return }
        self.sortedDic = dictionary
        hideIndicator()
    }
}

extension RankingBaseTableViewController {
    func showIndicator() {
        DispatchQueue.main.async {
            ERProgressHud.show()
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
    }
    func hideIndicator() {
        DispatchQueue.main.async {
            ERProgressHud.hide()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            self.tableView.reloadData()
        }
    }
}
