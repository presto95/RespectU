//
//  TrophyLinkDiskTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 6. 28..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class TrophyLinkDiskTableViewController: TrophyBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        API.fetchTrophies(of: "linkdisk")
    }
}

extension TrophyLinkDiskTableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "LINK DISK")
    }
}
