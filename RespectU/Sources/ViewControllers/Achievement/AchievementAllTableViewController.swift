//
//  AchievementAllTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import XLPagerTabStrip

/// The achievement table view controller about the all types.
final class AchievementAllTableViewController: AchievementBaseTableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    results = AchievementInfo.fetch(byType: .all)
    makeNumberOfStages()
  }
}

// MARK: - UITableView

extension AchievementAllTableViewController {
  
  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return makeAchievementCell(at: indexPath, isAll: true)
  }
}

// MARK: - Conforming IndicatorInfoProvider

extension AchievementAllTableViewController: IndicatorInfoProvider {
  
  func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
    return IndicatorInfo(title: "ALL")
  }
}
