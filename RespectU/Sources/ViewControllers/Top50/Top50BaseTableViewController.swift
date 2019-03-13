//
//  Top50BaseTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 3..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import RealmSwift

class Top50BaseTableViewController: UITableViewController {
  
  var tempResults: Results<RecordInfo>!
  
  var results: [RecordInfo]!
  
  let cellIdentifier = "top50Cell"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tempResults = RecordInfo.fetch()
    tableView.showsVerticalScrollIndicator = false
    tableView.separatorStyle = .none
    tableView.rowHeight = 60
    tableView.register(UINib(nibName: Top50Cell.name, bundle: nil),
                       forCellReuseIdentifier: cellIdentifier)
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 50
  }
}
