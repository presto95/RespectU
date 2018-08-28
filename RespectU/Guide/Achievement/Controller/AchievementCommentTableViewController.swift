//
//  AchievementCommentTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class AchievementCommentTableViewController: AchievementBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        API.requestAchievements(of: "comment")
    }
}

extension AchievementCommentTableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "COMMENT")
    }
}

