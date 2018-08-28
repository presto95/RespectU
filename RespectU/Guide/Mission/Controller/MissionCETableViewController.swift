//
//  MissionCETableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class MissionCETableViewController: MissionBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        API.fetchMissions(of: "ce")
    }
}

extension MissionCETableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "CLAZZIQUAI")
    }
}
