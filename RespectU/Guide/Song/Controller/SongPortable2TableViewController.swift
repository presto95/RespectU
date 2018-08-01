//
//  SongPortable2TableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 3..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import RealmSwift

class SongPortable2TableViewController: SongBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.songResults = realm.objects(SongInfo.self).filter("series = '\(Series.portable2)'").sorted(byKeyPath: "lowercase")
    } 
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.songResults.count
    }
}

extension SongPortable2TableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "PORTABLE 2")
    }
}
