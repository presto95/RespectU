//
//  Top505BTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import XLPagerTabStrip

/// The top50 table view controller about the 5B.
final class Top505BTableViewController: Top50BaseTableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    results = tempResults.sorted { $0.button5?.skillPoint ?? 0 > $1.button5?.skillPoint ?? 0 }
  }
}

// MARK: - UITableView Configuration

extension Top505BTableViewController {
  
  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
    if case let top50Cell as Top50Cell = cell {
      let object = results[indexPath.row]
      top50Cell.configure(with: object, button: .button8)
    }
    return cell
  }
}

// MARK: - Conforming IndicatorInfoProvider

extension Top505BTableViewController: IndicatorInfoProvider {
  
  func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
    return IndicatorInfo(title: Button.button5.rawValue.uppercased())
  }
}
