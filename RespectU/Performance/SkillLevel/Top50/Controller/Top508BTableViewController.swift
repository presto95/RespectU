//
//  Top508BTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class Top508BTableViewController: Top50BaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.results = RecordInfo.get().sorted(byKeyPath: Skill.button8SkillPoint, ascending: false)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? Top50Cell else { return UITableViewCell() }
        let object = results[indexPath.row]
        cell.setProperties(object, button: Buttons.button8)
        return cell
    }
}

extension Top508BTableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: Buttons.button8)
    }
}
