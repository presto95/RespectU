//
//  RecordPortable2TableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 4. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class RecordPortable2TableViewController: RecordBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.results = RecordInfo.get().filter(key: "series", value: Series.portable2, method: FilterOperator.equal).sorted(byKeyPath: "lowercase")
    }
}

extension RecordPortable2TableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "PORTABLE 2")
    }
}
