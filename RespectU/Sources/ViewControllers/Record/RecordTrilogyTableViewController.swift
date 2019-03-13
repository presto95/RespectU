//
//  RecordTrilogyTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 4. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import XLPagerTabStrip

/// The record table view controller about the TRILOGY series.
final class RecordTrilogyTableViewController: RecordBaseTableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    songResults = tempSongResults?
      .filter { $0.seriesEnum == .trilogy }
      .sorted { $0.localizedLowercase < $1.localizedLowercase }
  }
}

// MARK: - Conforming IndicatorInfoProvider

extension RecordTrilogyTableViewController: IndicatorInfoProvider {
  
  func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
    return IndicatorInfo(title: "TRILOGY")
  }
}
