//
//  SongBSTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 6. 28..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import RealmSwift

class SongBSTableViewController: SongBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.songResults = realm.objects(SongInfo.self).filter("series = '\(Series.bs)'").sorted(byKeyPath: "lowercase")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.songResults.count
    }
}

extension SongBSTableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "BLACK SQUARE")
    }
}
