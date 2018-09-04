//
//  TrophyTechnikaTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 21..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class TrophyTechnika1TableViewController: TrophyBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.results = TrophyInfo.fetch(of: Series.technika1)
    }
}

extension TrophyTechnika1TableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let row = indexPath.row
        if row == 9 {
            UIAlertController
                .alert(title: "Hidden BGA", message: "Thor")
                .action(title: "OK".localized)
                .present(to: self)
        }
    }
}

extension TrophyTechnika1TableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "TECHNIKA 1")
    }
}

