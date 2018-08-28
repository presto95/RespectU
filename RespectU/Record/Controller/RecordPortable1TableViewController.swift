//
//  RecordPortable1TableViewController.swift
//  
//
//  Created by Presto on 2018. 4. 4..
//

import UIKit
import XLPagerTabStrip

class RecordPortable1TableViewController: RecordBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        API.requestSongs(of: "portable1")
    }
}

extension RecordPortable1TableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "PORTABLE 1")
    }
}
