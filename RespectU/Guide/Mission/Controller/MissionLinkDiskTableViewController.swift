//
//  MissionLinkDiskTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 6. 28..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class MissionLinkDiskTableViewController: MissionBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.results = MissionInfo.fetch(of: Series.linkDisk)
    }
}

extension MissionLinkDiskTableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "LINK DISK")
    }
}
