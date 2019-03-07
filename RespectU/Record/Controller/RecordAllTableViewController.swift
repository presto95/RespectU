//
//  RecordAllTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 4. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import XLPagerTabStrip

final class RecordAllTableViewController: RecordBaseTableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.songResults = self.tempSongResults?.sorted { $0.localizedLowercase < $1.localizedLowercase }
  }
}

extension RecordAllTableViewController: IndicatorInfoProvider {
  
  func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
    return IndicatorInfo(title: "All")
  }
}
