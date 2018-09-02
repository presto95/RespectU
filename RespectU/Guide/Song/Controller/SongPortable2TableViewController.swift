//
//  SongPortable2TableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 3..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class SongPortable2TableViewController: SongBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.songResults = self.songResults?.filter(key: "series", value: Series.portable2, method: FilterOperator.equal)
    }
}

extension SongPortable2TableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "PORTABLE 2")
    }
}
