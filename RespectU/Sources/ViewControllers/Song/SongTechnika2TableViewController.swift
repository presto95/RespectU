//
//  SongTechnika2TableViewController.swift
//  RespectU
//
//  Created by Presto on 11/10/2018.
//  Copyright © 2018 Presto. All rights reserved.
//

import UIKit

import XLPagerTabStrip

/// The song table view controller about the TECHNIKA 2 series.
final class SongTechnika2TableViewController: SongBaseTableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    songResults = songResults?.filter { $0.seriesEnum == .technika2 }
  }
}

// MARK: - Conforming IndicatorInfoProvider

extension SongTechnika2TableViewController: IndicatorInfoProvider {
  
  func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
    return IndicatorInfo(title: "TECHNIKA 2")
  }
}
