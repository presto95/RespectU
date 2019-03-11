//
//  TrophyTechnika2TableViewController.swift
//  RespectU
//
//  Created by Presto on 11/10/2018.
//  Copyright © 2018 Presto. All rights reserved.
//

import UIKit

import XLPagerTabStrip

final class TrophyTechnika2TableViewController: TrophyBaseTableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    results = TrophyInfo.fetch(bySeries: .technika2)
  }
}

extension TrophyTechnika2TableViewController: IndicatorInfoProvider {
  
  func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
    return IndicatorInfo(title: "TECHNIKA 2")
  }
}
