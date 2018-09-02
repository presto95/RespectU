//
//  RecordRespectTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 4. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class RecordRespectTableViewController: RecordBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.songResults = self.tempSongResults?.filter(key: "series", value: Series.respect, method: FilterOperator.equal).sorted { $0.localizedLowercase < $1.localizedLowercase }
    }
}

extension RecordRespectTableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "RESPECT")
    }
}
