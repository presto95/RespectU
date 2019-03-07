//
//  RecordTechnika2TableViewController.swift
//  RespectU
//
//  Created by Presto on 11/10/2018.
//  Copyright © 2018 Presto. All rights reserved.
//

import UIKit

import XLPagerTabStrip

final class RecordTechnika2TableViewController: RecordBaseTableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    songResults = tempSongResults?.filter(key: "series", value: Series.technika2, method: "=").sorted { $0.localizedLowercase < $1.localizedLowercase }
  }
}

extension RecordTechnika2TableViewController: IndicatorInfoProvider {
  
  func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
    return IndicatorInfo(title: "TECHNIKA 2")
  }
}
