//
//  TrophyBaseTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import RealmSwift

class TrophyBaseTableViewController: UITableViewController {
  
  var results: Results<TrophyInfo>?
  
  let cellIdentifier = "trophyCell"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
  }
  
  private func configure() {
    tableView.rowHeight = 60
    tableView.showsVerticalScrollIndicator = false
    tableView.separatorStyle = .none
    tableView.register(UINib(nibName: TrophyCell.name, bundle: nil),
                       forCellReuseIdentifier: cellIdentifier)
  }
}

extension TrophyBaseTableViewController {
  
  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
    if case let trophyCell as TrophyCell = cell {
      if indexPath.row < results?.count ?? 0 {
        let result = results?[indexPath.row]
        trophyCell.configure(with: result)
      }
    }
    return cell
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return results?.count ?? 0
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
