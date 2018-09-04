
//
//  Top50BaseTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 3..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import RealmSwift

class Top50BaseTableViewController: BaseTableViewController {

    var tempResults: Results<NewRecordInfo>!
    var results: [NewRecordInfo]!
    let cellIdentifier = "top50Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tempResults = NewRecordInfo.fetch()
        self.tableView.rowHeight = 60
        self.tableView.register(UINib(nibName: "Top50Cell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
}
