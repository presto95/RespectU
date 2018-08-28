//
//  SongCETableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 3..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class SongCETableViewController: SongBaseTableViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        API.requestSongs(of: "ce")
    }
}

extension SongCETableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "CLAZZIQUAI")
    }
}

