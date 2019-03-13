//
//  AchievementPlateTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 27..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import XLPagerTabStrip

/// The achievement table view controller about the plate type.
final class AchievementPlateTableViewController: AchievementBaseTableViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    results = AchievementInfo.fetch(byType: .plate)
    makeNumberOfStages()
  }
}

// MARK: - Conforming IndicatorInfoProvider

extension AchievementPlateTableViewController: IndicatorInfoProvider {
  
  func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
    return IndicatorInfo(title: "PLATE")
  }
}
