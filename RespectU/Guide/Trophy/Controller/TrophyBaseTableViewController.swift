//
//  TrophyBaseTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import RealmSwift


class TrophyBaseTableViewController: GuideBaseTableViewController {

    var results: Results<TrophyInfo>!
    let cellIdentifier = "trophyCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "TrophyCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? TrophyCell else { return UITableViewCell() }
        let object = results[indexPath.row]
        cell.setProperties(object)
    }
}