//
//  AchievementMusicTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class AchievementMusicTableViewController: AchievementBaseTableViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        API.fetchAchievements(of: "music")
    }
}

extension AchievementMusicTableViewController: IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "MUSIC")
    }
}

