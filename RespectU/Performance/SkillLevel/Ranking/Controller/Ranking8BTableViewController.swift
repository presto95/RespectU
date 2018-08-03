//
//  Ranking8BTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class Ranking8BTableViewController: RankingBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showIndicator()
        Firebase.fetch("button8SkillPoint")
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveFirebaseFetch(_:)), name: .didReceiveFirebaseFetch, object: nil)
    }
}

extension Ranking8BTableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "8B")
    }
}
