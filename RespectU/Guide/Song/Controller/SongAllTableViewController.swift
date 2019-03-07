//
//  SongAllTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 3..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import XLPagerTabStrip

final class SongAllTableViewController: SongBaseTableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

extension SongAllTableViewController: IndicatorInfoProvider {
  
  func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
    return IndicatorInfo(title: "ALL")
  }
}
