//
//  Ranking4BTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import SVProgressHUD
import XLPagerTabStrip

class Ranking4BTableViewController: RankingBaseTableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    SVProgressHUD.show()
    API.requestRankings { response, error in
      if let error = error {
        UIAlertController.presentErrorAlert(to: self, error: error.localizedDescription)
        return
      }
      guard let response = response else { return }
      self.results = response.rankings.sorted { $0.button4 > $1.button4 }
      DispatchQueue.main.async { [weak self] in
        self?.tableView.reloadData()
        SVProgressHUD.dismiss()
      }
    }
  }
}

extension Ranking4BTableViewController {
  
  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
    if case let rankingCell as RankingCell = cell {
      rankingCell.configure(results, at: indexPath.row, button: Button.button4)
    }
    return cell
  }
}

extension Ranking4BTableViewController: IndicatorInfoProvider {
  
  func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
    return IndicatorInfo(title: Button.button4.uppercased())
  }
}
