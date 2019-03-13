//
//  TrophyRespectTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import XLPagerTabStrip

/// The trophy table view controller about the RESPECT series.
final class TrophyRespectTableViewController: TrophyBaseTableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    results = TrophyInfo.fetch(bySeries: .respect)
  }
}

// MARK: - UITableView Configuration

extension TrophyRespectTableViewController {
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let row = indexPath.row
    var title: String = ""
    var message: String = ""
    if row == 36 || row == 37 {
      title = L10n.hiddenBGAs
      message = "A Lie\nEnemy Storm\nNB RANGER - Virgin Force\nNever Say\nWhiteBlue\nOut Law"
    } else if row == 26 {
      title = L10n._777Combos
      message = L10n._5BNORMALSeeker47CombosBREAKFullComboTrophyEarned
    } else if row == 41 {
      title = L10n.credits
      message = L10n.creditsWillAppearWhenTheAverageAccuracyOfThreeStagesAreGreaterThan98
    }
    if !title.isEmpty, !message.isEmpty {
      UIAlertController
        .alert(title: title, message: message)
        .action(title: L10n.ok)
        .present(to: self)
    }
  }
}

// MARK: - Conforming IndicatorInfoProvider

extension TrophyRespectTableViewController: IndicatorInfoProvider {
  
  func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
    return IndicatorInfo(title: "RESPECT")
  }
}
