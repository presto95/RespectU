//
//  AchievementNoteTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import XLPagerTabStrip

/// The achievement table view controller about the note skin type.
final class AchievementNoteTableViewController: AchievementBaseTableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    results = AchievementInfo.fetch(byType: .noteSkin)
    makeNumberOfStages()
  }
}

// MARK: - Conforming IndicatorInfoProvider

extension AchievementNoteTableViewController: IndicatorInfoProvider {
  
  func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
    return IndicatorInfo(title: "NOTE SKIN")
  }
}
