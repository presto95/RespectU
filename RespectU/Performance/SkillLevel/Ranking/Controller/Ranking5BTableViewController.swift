//
//  Ranking5BTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class Ranking5BTableViewController: RankingBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showIndicator()
        API.requestRankings()
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveRankings(_:)), name: .didReceiveRankings, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(errorReceiveRankings(_:)), name: .errorReceiveRankings, object: nil)
    }
}

extension Ranking5BTableViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? RankingCell else { return UITableViewCell() }
        cell.setProperties(results, at: indexPath.row, button: Buttons.button5)
        return cell
    }
}

extension Ranking5BTableViewController {
    @objc func didReceiveRankings(_ notification: Notification) {
        guard let userInfo = notification.userInfo?["rankings"] as? RankingResponse else { return }
        self.results = userInfo.rankings.sorted { $0.button5 > $1.button5 }
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            self?.hideIndicator()
        }
    }
    
    @objc func errorReceiveRankings(_ notification: Notification) {
        UIAlertController
            .alert(title: "", message: "Network Error".localized)
            .action(title: "OK".localized) { [weak self] _ in
                self?.hideIndicator()
                self?.dismiss(animated: true, completion: nil)
            }
            .present(to: self)
    }
}

extension Ranking5BTableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "5B")
    }
}
