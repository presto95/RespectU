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
}

extension RankingBaseTableViewController {
    func fetchFirebase(_ key: String) {
        var userIds = [String]()
        var values = [Double]()
        let ref = Database.database().reference()
        ref.child("users").observeSingleEvent(of: .value) { snapshot in
            DispatchQueue.main.async {
                ERProgressHud.show()
            }
            var dic = [String: Double]()
            for child in snapshot.children {
                guard let snap = child as? DataSnapshot else { return }
                for child in snap.children {
                    guard let snap = child as? DataSnapshot else { return }
                    if snap.key == "userId" {
                        guard let userId = snap.value as? String else { return }
                        userIds.append(userId)
                    }
                    if snap.key == key {
                        guard let value = snap.value as? Double else { return }
                        values.append(value)
                    }
                }
            }
            for index in 0..<userIds.count {
                dic[userIds[index]] = values[index]
            }
            self.sortedDic = dic.sorted { $0.value > $1.value }
            DispatchQueue.main.async {
                ERProgressHud.hide()
                self.tableView.reloadData()
            }
        }
    }
}
