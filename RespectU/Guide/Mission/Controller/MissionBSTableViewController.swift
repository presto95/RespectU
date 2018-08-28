//
//  MissionBSTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 6. 28..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class MissionBSTableViewController: MissionBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        API.fetchMissions(of: "bs")
    }
}

extension MissionBSTableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "BLACK SQUARE")
    }
}
