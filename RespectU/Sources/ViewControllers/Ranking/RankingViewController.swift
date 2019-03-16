//
//  RankingViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import XLPagerTabStrip

/// The ranking view controller.
final class RankingViewController: ButtonBarPagerTabStripBaseViewController {
  
  /// The table view controller representing the 4B.
  private lazy var ranking4bTableViewController = Ranking4BTableViewController()
  
  /// The table view controller representing the 5B.
  private lazy var ranking5bTableViewController = Ranking5BTableViewController()
  
  /// The table view controller representing the 6B.
  private lazy var ranking6bTableViewController = Ranking6BTableViewController()
  
  /// The table view controller representing the 8B.
  private lazy var ranking8bTableViewController = Ranking8BTableViewController()
  
  override func viewControllers(
    for pagerTabStripController: PagerTabStripViewController
  ) -> [UIViewController] {
    return [
      ranking4bTableViewController,
      ranking5bTableViewController,
      ranking6bTableViewController,
      ranking8bTableViewController
    ]
  }
  
  /// Tells the `sender` that the cancel button is tapped.
  @IBAction private func cancelButtonDidTap(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
}
