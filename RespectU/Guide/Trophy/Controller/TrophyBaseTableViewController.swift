//
//  TrophyBaseTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import RealmSwift


class TrophyBaseTableViewController: BaseTableViewController {

    var results: Results<TrophyInfo>?
    let cellIdentifier = "trophyCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 60
        self.tableView.register(UINib(nibName: "TrophyCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
}

extension TrophyBaseTableViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TrophyCell else { return UITableViewCell() }
        let row = indexPath.row
        let count = self.results?.count ?? 0
        if row < count {
            let object = self.results?[indexPath.row]
            cell.setProperties(object)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.results?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
