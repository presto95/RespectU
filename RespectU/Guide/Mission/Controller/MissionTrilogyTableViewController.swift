//
//  MissionTrilogyTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class MissionTrilogyTableViewController: MissionBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        results = MissionInfo.fetch(of: Series.trilogy)
    }
}

extension MissionTrilogyTableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "TRILOGY")
    }
}
