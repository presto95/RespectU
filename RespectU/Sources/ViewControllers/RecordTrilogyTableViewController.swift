//
//  RecordTrilogyTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 4. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import XLPagerTabStrip

final class RecordTrilogyTableViewController: RecordBaseTableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.songResults = self.tempSongResults?.filter(key: "series", value: Series.trilogy, method: "=").sorted { $0.localizedLowercase < $1.localizedLowercase }
  }
}

extension RecordTrilogyTableViewController: IndicatorInfoProvider {
  
  func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
    return IndicatorInfo(title: "TRILOGY")
  }
}