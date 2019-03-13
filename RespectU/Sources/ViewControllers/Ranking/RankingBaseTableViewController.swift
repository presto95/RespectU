//
//  RankingBaseTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 3..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import RealmSwift

/// The ranking base table view controller.
class RankingBaseTableViewController: UITableViewController {
  
  /// The api service.
  let apiService: APIServiceType = APIService()
  
  /// The cell identifier.
  let cellIdentifier = "rankingCell"
  
  /// The requestsed ranking results.
  var results: [RankingResponse.Ranking] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
  }
  
  /// Configures initial settings.
  private func configure() {
    tableView.do {
      $0.showsVerticalScrollIndicator = false
      $0.separatorStyle = .none
      $0.rowHeight = 40
      $0.register(UINib(nibName: RankingCell.name, bundle: nil),
                  forCellReuseIdentifier: cellIdentifier)
    }
  }
}

// MARK: - UITableView Confiruation

extension RankingBaseTableViewController {
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return results.count
  }
}
