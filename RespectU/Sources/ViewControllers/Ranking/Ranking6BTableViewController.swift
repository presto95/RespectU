//
//  Ranking6BTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import SVProgressHUD
import XLPagerTabStrip

/// The ranking table view controller about the 6B.
final class Ranking6BTableViewController: RankingBaseTableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    SVProgressHUD.show()
    apiService.requestRankings { [weak self] response, error in
      guard let self = self else { return }
      if let error = error {
        self.present(UIAlertController.makeErrorAlert(error), animated: true, completion: nil)
        return
      }
      guard let response = response else { return }
      self.results = response.rankings.sorted { $0.button6 > $1.button6 }
      DispatchQueue.main.async {
        self.tableView.reloadData()
        SVProgressHUD.dismiss()
      }
    }
  }
}

// MARK: - UITableView Configuration

extension Ranking6BTableViewController {
  
  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
    if case let rankingCell as RankingCell = cell {
      rankingCell.configure(with: results, at: indexPath.row, button: .button6)
    }
    return cell
  }
}

// MARK: - Conforming IndicatorInfoProvider

extension Ranking6BTableViewController: IndicatorInfoProvider {
  
  func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
    return IndicatorInfo(title: Button.button6.rawValue.uppercased())
  }
}
