//
//  SongTrilogyTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 3..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class SongTrilogyTableViewController: SongBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.songResults = self.songResults?.filter(key: "series", value: Series.trilogy, method: FilterOperator.equal)
    }
}

extension SongTrilogyTableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "TRILOGY")
    }
}
