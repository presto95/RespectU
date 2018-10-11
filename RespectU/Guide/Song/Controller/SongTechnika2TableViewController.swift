//
//  SongTechnika2TableViewController.swift
//  RespectU
//
//  Created by Presto on 11/10/2018.
//  Copyright © 2018 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class SongTechnika2TableViewController: SongBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.songResults = self.songResults?.filter { $0.series == Series.technika2 }
    }
}

extension SongTechnika2TableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "TECHNIKA 2")
    }
}
