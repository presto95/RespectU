//
//  TrophyTrilogyTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import XLPagerTabStrip

/// The trophy table view controller about the TRILOGY series.
final class TrophyTrilogyTableViewController: TrophyBaseTableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    results = TrophyInfo.fetch(bySeries: .trilogy)
  }
}

// MARK: - UITableView Configuration

extension TrophyTrilogyTableViewController {
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    if indexPath.row == 6 {
      UIAlertController
        .alert(title: L10n.hiddenBGA, message: "STOP")
        .action(title: L10n.ok)
        .present(to: self)
    }
  }
}

// MARK: - Conforming IndicatorInfoProvider

extension TrophyTrilogyTableViewController: IndicatorInfoProvider {
  
  func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
    return IndicatorInfo(title: "TRILOGY")
  }
}
