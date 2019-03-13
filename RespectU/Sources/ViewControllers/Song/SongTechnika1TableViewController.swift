//
//  SongTechnika1TableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 21..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import XLPagerTabStrip

/// The song table view controller about the TECHNIKA 1 series.
final class SongTechnika1TableViewController: SongBaseTableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    songResults = songResults?.filter { $0.seriesEnum == .technika1 }
  }
}

// MARK: - Conforming IndicatorInfoProvider

extension SongTechnika1TableViewController: IndicatorInfoProvider {
  
  func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
    return IndicatorInfo(title: "TECHNIKA 1")
  }
}
