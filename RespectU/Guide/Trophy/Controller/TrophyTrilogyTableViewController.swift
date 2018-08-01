//
//  TrophyTrilogyTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import RealmSwift

class TrophyTrilogyTableViewController: TrophyBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        results = realm.objects(TrophyInfo.self).filter("series = '\(Series.trilogy)'")
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = super.tableView(tableView, cellForRowAt: indexPath) as? TrophyCell else { return UITableViewCell() }
        let imageName = "trilogy\(indexPath.row + 1)"
        cell.trophyImageView.image = UIImage(named: imageName)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let row = indexPath.row
        if row == 6 {
            UIAlertController
                .alert(title: "Hidden BGA".localized, message: "STOP")
                .defaultAction(title: "OK".localized)
                .present(to: self)
        }
    }
}

extension TrophyTrilogyTableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "TRILOGY")
    }
}
