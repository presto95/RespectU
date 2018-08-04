//
//  AchievementGearTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class AchievementGearTableViewController: AchievementBaseTableViewController {

    override func viewDidLoad() {
        self.results = AchievementInfo.get().filter(key: "type", value: Achievement.gearSkin, method: FilterOperator.like)
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? AchievementCell else { return UITableViewCell() }
        var rowIndex = 0
        if indexPath.section > 0 {
            for i in 1...indexPath.section {
                rowIndex += stageCount[i - 1]
            }
        }
        rowIndex += indexPath.row
        let object = results[rowIndex]
        cell.setProperties(object)
        return cell
    }
}

extension AchievementGearTableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "GEAR SKIN")
    }
}
