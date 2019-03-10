//
//  RankingViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import XLPagerTabStrip

final class RankingViewController: BaseViewController {
  
  private lazy var ranking4bTableViewController = Ranking4BTableViewController()
  
  private lazy var ranking5bTableViewController = Ranking5BTableViewController()
  
  private lazy var ranking6bTableViewController = Ranking6BTableViewController()
  
  private lazy var ranking8bTableViewController = Ranking8BTableViewController()
  
  private lazy var rankingViewControllers: [RankingBaseTableViewController] = {
    return [
      ranking4bTableViewController,
      ranking5bTableViewController,
      ranking6bTableViewController,
      ranking8bTableViewController
    ]
  }()
  
  override func viewControllers(
    for pagerTabStripController: PagerTabStripViewController
  ) -> [UIViewController] {
    return rankingViewControllers
  }
  
  @IBAction func didTapCancelButton(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
}
