//
//  TrophyCETableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class TrophyCETableViewController: TrophyBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        API.requestTrophies(of: "ce")
    }
}

extension TrophyCETableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let row = indexPath.row
        if row == 6 {
            UIAlertController
                .alert(title: "Hidden BGA".localized, message: "First Kiss")
                .defaultAction(title: "OK".localized)
                .present(to: self)
        }
    }
}

extension TrophyCETableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "CLAZZIQUAI")
    }
}
