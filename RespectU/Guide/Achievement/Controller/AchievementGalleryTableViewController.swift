//
//  AchievementGalleryTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class AchievementGalleryTableViewController: AchievementBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.results = AchievementInfo.fetch(of: "gallery")
        generateStageCounts()
    }
}

extension AchievementGalleryTableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "GALLERY")
    }
}

