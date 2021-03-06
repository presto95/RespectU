//
//  MissionCETableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import XLPagerTabStrip

/// The mission table view controller about the CLAZZIQUAI EDITION series.
final class MissionCETableViewController: MissionBaseTableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    results = MissionInfo.fetch(bySeries: .ce)
  }
}

// MARK: - Conforming IndicatorInfoProvider

extension MissionCETableViewController: IndicatorInfoProvider {
  
  func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
    return IndicatorInfo(title: "CLAZZIQUAI")
  }
}
