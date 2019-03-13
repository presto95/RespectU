//
//  RecordBSTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 6. 28..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import XLPagerTabStrip

/// The record table view controller about the BLACK SQUARE series.
final class RecordBSTableViewController: RecordBaseTableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    songResults = tempSongResults?
      .filter { $0.seriesEnum == .bs }
      .sorted { $0.localizedLowercase < $1.localizedLowercase }
  }
}

// MARK: - Conforming IndicatorInfoProvider

extension RecordBSTableViewController: IndicatorInfoProvider {
  
  func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
    return IndicatorInfo(title: "BLACK SQUARE")
  }
}
