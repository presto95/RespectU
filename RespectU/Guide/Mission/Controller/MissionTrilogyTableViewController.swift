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
        self.results = MissionInfo.get().filter(key: "type", value: Series.trilogy, method: FilterOperator.equal)
    }
}

extension MissionTrilogyTableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "TRILOGY")
    }
}
