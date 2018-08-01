//
//  SongTechnika1TableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 21..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import RealmSwift

class SongTechnika1TableViewController: SongBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.songResults = realm.objects(SongInfo.self).filter("series = '\(Series.technika1)'").sorted(byKeyPath: "lowercase")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.songResults.count
    }
}

extension SongTechnika1TableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "TECHNIKA 1")
    }
}
