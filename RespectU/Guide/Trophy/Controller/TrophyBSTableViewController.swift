//
//  TrophyBSTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 6. 28..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class TrophyBSTableViewController: TrophyBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        API.requestTrophies(of: "bs")
    }
}

extension TrophyBSTableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "BLACK SQUARE")
    }
}
