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
        self.tableView.rowHeight = 40
        self.tableView.register(UINib(nibName: "RankingCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveFirebaseFetch(_:)), name: .didReceiveFirebaseFetch, object: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? RankingCell else { return UITableViewCell() }
        cell.setProperties(sortedDic, at: indexPath.row, isPerfect: false)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sortedDic.count
    }
    
    @objc func didReceiveFirebaseFetch(_ notification: Notification) {
        guard let dictionary = notification.userInfo?["dictionary"] as? [(key: String, value: Double)] else { return }
        self.sortedDic = dictionary
        hideIndicator()
        DispatchQueue.main.async {
            self.tableView.reloadSections(IndexSet(0...0), with: .automatic)
        }
    }
}
