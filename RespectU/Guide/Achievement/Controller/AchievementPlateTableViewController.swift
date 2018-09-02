//
//  AchievementPlateTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 27..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class AchievementPlateTableViewController: AchievementBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.results = AchievementInfo.fetch(of: "plate")
    }
}

extension AchievementPlateTableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "PLATE")
    }
}
