//
//  MissionTechnika2TableViewController.swift
//  RespectU
//
//  Created by Presto on 11/10/2018.
//  Copyright © 2018 Presto. All rights reserved.
//

import UIKit

import XLPagerTabStrip

/// The mission table view controller about the TECHNIKA 2 series.
final class MissionTechnika2TableViewController: MissionBaseTableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    results = MissionInfo.fetch(bySeries: .technika2)
  }
}

// MARK: - Conforming IndicatorInfoProvider

extension MissionTechnika2TableViewController: IndicatorInfoProvider {
  
  func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
    return IndicatorInfo(title: "TECHNIKA 2")
  }
}
