//
//  AchievementAllTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import XLPagerTabStrip

final class AchievementAllTableViewController: AchievementBaseTableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    results = AchievementInfo.fetch()
    generateStageCounts()
  }
}

extension AchievementAllTableViewController {
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return achievementCell(at: indexPath, isAll: true)
  }
}

extension AchievementAllTableViewController: IndicatorInfoProvider {
  
  func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
    return IndicatorInfo(title: "ALL")
  }
}
