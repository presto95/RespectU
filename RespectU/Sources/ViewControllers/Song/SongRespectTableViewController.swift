//
//  SongRespectTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 3..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import XLPagerTabStrip

/// The song table view controller about the RESPECT series.
final class SongRespectTableViewController: SongBaseTableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    songResults = songResults?.filter { $0.seriesEnum == .respect }
  }
}

// MARK: - Conforming IndicatorInfoProvider

extension SongRespectTableViewController: IndicatorInfoProvider {
  
  func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
    return IndicatorInfo(title: "RESPECT")
  }
}
