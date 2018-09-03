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
        self.songResults = self.tempSongResults?.filter(key: "series", value: Series.portable1, method: "=").sorted { $0.localizedLowercase < $1.localizedLowercase }
    }
}

extension RecordPortable1TableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "PORTABLE 1")
    }
}
