//
//  SongRespectTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 3..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class SongRespectTableViewController: SongBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.songResults = self.songResults?.filter(key: "series", value: Series.respect, method: FilterOperator.equal)
    }
}

extension SongRespectTableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "RESPECT")
    }
}
