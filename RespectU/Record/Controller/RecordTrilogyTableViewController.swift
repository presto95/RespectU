//
//  RecordTrilogyTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 4. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class RecordTrilogyTableViewController: RecordBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        API.requestSongs(of: "trilogy")
    }
}

extension RecordTrilogyTableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "TRILOGY")
    }
}
