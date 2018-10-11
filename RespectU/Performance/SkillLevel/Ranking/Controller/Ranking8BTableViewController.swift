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
        API.requestRankings { response, error in
            if let error = error {
                UIAlertController.presentErrorAlert(to: self, error: error.localizedDescription)
                return
            }
            guard let response = response else { return }
            self.results = response.rankings.sorted { $0.button8 > $1.button8 }
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
                self?.hideIndicator()
            }
        }
    }
}

extension Ranking8BTableViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? RankingCell else { return UITableViewCell() }
        cell.setProperties(results, at: indexPath.row, button: Buttons.button8)
        return cell
    }
}

extension Ranking8BTableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: Buttons.button8.uppercased())
    }
}
