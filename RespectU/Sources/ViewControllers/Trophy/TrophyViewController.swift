//
//  TrophyViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import XLPagerTabStrip

/// The trophy view controller.
final class TrophyViewController: ButtonBarPagerTabStripBaseViewController {
  
  /// The table view controller representing the RESPECT series.
  private lazy var respectTableViewController = TrophyRespectTableViewController()
  
  /// The table view controller representing the TRILOGY series.
  private lazy var trilogyTableViewController = TrophyTrilogyTableViewController()
  
  /// The table view controller representing the CLAZZIQUAI EDITION series.
  private lazy var ceTableViewController = TrophyCETableViewController()
  
  /// The table view controller representing the TECHNIKA 1 series.
  private lazy var technika1TableViewController = TrophyTechnika1TableViewController()
  
  /// The table view controller representing the BLACK SQUARE series.
  private lazy var bsTableViewController = TrophyBSTableViewController()
  
  /// The table view controller representing the LINK DISK series.
  private lazy var linkDiskTableViewController = TrophyLinkDiskTableViewController()
  
  /// The table view controller representing the TECHNIKA 2 series.
  private lazy var technika2TableViewController = TrophyTechnika2TableViewController()
  
  /// The table view controller representing the TECNNIKA 3 series.
  private lazy var technika3TableViewController = TrophyTechnika3TableViewController()
  
  override func viewControllers(
    for pagerTabStripController: PagerTabStripViewController
  ) -> [UIViewController] {
    return [
      respectTableViewController,
      trilogyTableViewController,
      ceTableViewController,
      technika1TableViewController,
      bsTableViewController,
      linkDiskTableViewController,
      technika2TableViewController,
      technika3TableViewController
    ]
  }
  
  /// Tells the `sender` that the cancel button is tapped.
  @IBAction private func cancelButtonDidTap(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
}
