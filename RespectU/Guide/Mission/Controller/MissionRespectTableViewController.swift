//
//  MissionRespectTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class MissionRespectTableViewController: MissionBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        API.requestMissions(of: "respect")
    }
}

extension MissionRespectTableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "RESPECT")
    }
}
