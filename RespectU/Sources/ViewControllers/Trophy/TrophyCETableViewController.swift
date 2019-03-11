//
//  TrophyCETableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import XLPagerTabStrip

final class TrophyCETableViewController: TrophyBaseTableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    results = TrophyInfo.fetch(bySeries: .ce)
  }
}

extension TrophyCETableViewController {
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    if indexPath.row == 6 {
      UIAlertController
        .alert(title: L10n.hiddenBGA, message: "First Kiss")
        .action(title: L10n.ok)
        .present(to: self)
    }
  }
}

extension TrophyCETableViewController: IndicatorInfoProvider {
  
  func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
    return IndicatorInfo(title: "CLAZZIQUAI")
  }
}
