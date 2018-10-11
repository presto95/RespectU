//
//  TrophyTechnika2TableViewController.swift
//  RespectU
//
//  Created by Presto on 11/10/2018.
//  Copyright © 2018 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class TrophyTechnika2TableViewController: TrophyBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.results = TrophyInfo.fetch(of: Series.technika2)
    }
}

extension TrophyTechnika2TableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "TECHNIKA 2")
    }
}
