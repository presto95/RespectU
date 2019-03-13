//
//  MissionTechnika3TableViewController.swift
//  RespectU
//
//  Created by Presto on 10/03/2019.
//  Copyright © 2019 Presto. All rights reserved.
//

import UIKit

import XLPagerTabStrip

/// The mission table view controller about the TECHNIKA 3 series.
final class MissionTechnika3TableViewController: MissionBaseTableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    results = MissionInfo.fetch(bySeries: .technika3)
  }
}

// MARK: - Conforming IndicatorInfoProvider

extension MissionTechnika3TableViewController: IndicatorInfoProvider {
  
  func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
    return IndicatorInfo(title: "TECHNIKA 3")
  }
}
