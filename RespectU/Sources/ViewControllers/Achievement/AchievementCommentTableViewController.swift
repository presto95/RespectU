//
//  AchievementCommentTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import XLPagerTabStrip

/// The achievement table view controller about the comment type.
final class AchievementCommentTableViewController: AchievementBaseTableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    results = AchievementInfo.fetch(byType: .comment)
    makeNumberOfStages()
  }
}

// MARK: - Conforming IndicatorInfoProvider

extension AchievementCommentTableViewController: IndicatorInfoProvider {
  
  func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
    return IndicatorInfo(title: "COMMENT")
  }
}
