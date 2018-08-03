//
//  RankingPPTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class RankingPPTableViewController: RankingBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showIndicator()
        Firebase.fetch("countPerfectPlay")
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveFirebaseFetch(_:)), name: .didReceiveFirebaseFetch, object: nil)
    }
}

extension RankingPPTableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "PP")
    }
}
