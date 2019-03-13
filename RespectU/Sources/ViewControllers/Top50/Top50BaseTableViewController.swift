//
//  Top50BaseTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 3..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import RealmSwift

/// The top50 base table view controller.
class Top50BaseTableViewController: UITableViewController {
  
  /// The fetched temperature record results.
  var tempResults: Results<RecordInfo>!
  
  /// The processed record results.
  var results: [RecordInfo]!
  
  /// The cell identifier.
  let cellIdentifier = "top50Cell"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
  }
  
  /// Configures initial settings.
  private func configure() {
    tempResults = RecordInfo.fetch()
    tableView.showsVerticalScrollIndicator = false
    tableView.separatorStyle = .none
    tableView.rowHeight = 60
    tableView.register(UINib(nibName: Top50Cell.name, bundle: nil),
                       forCellReuseIdentifier: cellIdentifier)
  }
}

// MARK: - UITableView Configuration

extension Top50BaseTableViewController {
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 50
  }
}
