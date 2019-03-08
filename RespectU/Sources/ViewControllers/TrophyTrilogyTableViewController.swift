//
//  TrophyTrilogyTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import XLPagerTabStrip

final class TrophyTrilogyTableViewController: TrophyBaseTableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    results = TrophyInfo.fetch(of: Series.trilogy)
  }
}

extension TrophyTrilogyTableViewController {
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let row = indexPath.row
    if row == 6 {
      UIAlertController
        .alert(title: "Hidden BGA".localized, message: "STOP")
        .action(title: "OK".localized)
        .present(to: self)
    }
  }
}

extension TrophyTrilogyTableViewController: IndicatorInfoProvider {
  
  func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
    return IndicatorInfo(title: "TRILOGY")
  }
}
