//
//  AchievementGearTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class AchievementGearTableViewController: AchievementBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        API.fetchAchievements(of: "gear")
    }
}

extension AchievementGearTableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "GEAR SKIN")
    }
}
