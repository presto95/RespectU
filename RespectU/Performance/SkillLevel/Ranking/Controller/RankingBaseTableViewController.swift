//
//  RankingBaseTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 3..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import RealmSwift

class RankingBaseTableViewController: BaseTableViewController {
    
    let nickname = UserDefaults.standard.string(forKey: "nickname") ?? ""
    let cellIdentifier = "rankingCell"
    var results: [RankingResponse.Ranking] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 40
        self.tableView.register(UINib(nibName: "RankingCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
}

extension RankingBaseTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.results.count
    }
}
