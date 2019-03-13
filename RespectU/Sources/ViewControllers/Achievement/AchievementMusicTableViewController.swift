//
//  AchievementMusicTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import XLPagerTabStrip

/// The achievement table view controller about the music type.
final class AchievementMusicTableViewController: AchievementBaseTableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    results = AchievementInfo.fetch(byType: .music)
    makeNumberOfStages()
  }
}

// MARK: - Conforming IndicatorInfoProvider

extension AchievementMusicTableViewController: IndicatorInfoProvider {
  
  func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
    return IndicatorInfo(title: "MUSIC")
  }
}
