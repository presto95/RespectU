//
//  RecordTechnika1TableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 4. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import XLPagerTabStrip

final class RecordTechnika1TableViewController: RecordBaseTableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.songResults = self.tempSongResults?.filter(key: "series", value: Series.technika1, method: "=").sorted { $0.localizedLowercase < $1.localizedLowercase }
  }
}

extension RecordTechnika1TableViewController: IndicatorInfoProvider {
  
  func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
    return IndicatorInfo(title: "TECHNIKA 1")
  }
}
