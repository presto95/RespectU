//
//  Top508BTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import XLPagerTabStrip

final class Top508BTableViewController: Top50BaseTableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    results = tempResults.sorted { $0.button8?.skillPoint ?? 0 > $1.button8?.skillPoint ?? 0 }
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
    return IndicatorInfo(title: Buttons.button8.uppercased())
  }
}