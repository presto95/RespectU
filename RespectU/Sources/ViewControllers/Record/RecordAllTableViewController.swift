//
//  RecordAllTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 4. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import XLPagerTabStrip

/// The record table view controller about the all series.
final class RecordAllTableViewController: RecordBaseTableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    songResults = tempSongResults?.sorted { $0.localizedLowercase < $1.localizedLowercase }
  }
}

// MARK: - Conforming IndicatorInfoProvider

extension RecordAllTableViewController: IndicatorInfoProvider {
  
  func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
    return IndicatorInfo(title: "All")
  }
}
