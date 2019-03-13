//
//  RecordTechnika1TableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 4. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import XLPagerTabStrip

/// The record table view controller about the TECHNIKA 1 series.
final class RecordTechnika1TableViewController: RecordBaseTableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    songResults = tempSongResults?
      .filter { $0.seriesEnum == .technika1 }
      .sorted { $0.localizedLowercase < $1.localizedLowercase }
  }
}

// MARK: - Conforming IndicatorInfoProvider

extension RecordTechnika1TableViewController: IndicatorInfoProvider {
  
  func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
    return IndicatorInfo(title: "TECHNIKA 1")
  }
}
