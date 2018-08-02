//
//  RecordPortable1TableViewController.swift
//  
//
//  Created by Presto on 2018. 4. 4..
//

import UIKit
import XLPagerTabStrip
import RealmSwift

class RecordPortable1TableViewController: RecordBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.results = RecordInfo
                        .get()
                        .filter(key: "series", value: Series.portable1, method: FilterMethod.equal).sorted(byKeyPath: "lowercase")
    }
}

extension RecordPortable1TableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "PORTABLE 1")
    }
}
