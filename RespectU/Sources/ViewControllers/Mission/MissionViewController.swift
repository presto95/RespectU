//
//  MissionViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import XLPagerTabStrip

/// The mission view controller.
class MissionViewController: ButtonBarPagerTabStripBaseViewController {
  
  /// The table view representing the RESPECT series.
  private lazy var respectTableViewController = MissionRespectTableViewController()
  
  /// The table view representing the TRILOGY series.
  private lazy var trilogyTableViewController = MissionTrilogyTableViewController()
  
  /// The table view representing the CLAZZIQUAI EDITION series.
  private lazy var ceTableViewController = MissionCETableViewController()
  
  /// The table view representing the TECHNIKA 1 series.
  private lazy var technika1TableViewController = MissionTechnika1TableViewController()
  
  /// The table view representing the BLACK SQUARE series.
  private lazy var bsTableViewController = MissionBSTableViewController()
  
  /// The table view representing the TECHNIKA 2 series.
  private lazy var technika2TableViewController = MissionTechnika2TableViewController()
  
  /// The table view representing the LINK DISK series.
  private lazy var linkDiskTableViewController = MissionLinkDiskTableViewController()
  
  /// The table view representing the TECHNIKA 3 series.
  private lazy var technika3TableViewController = MissionTechnika3TableViewController()
  
  override func viewControllers(
    for pagerTabStripController: PagerTabStripViewController
  ) -> [UIViewController] {
    return [
      respectTableViewController,
      trilogyTableViewController,
      ceTableViewController,
      technika1TableViewController,
      bsTableViewController,
      technika2TableViewController,
      linkDiskTableViewController,
      technika3TableViewController
    ]
  }
  
  /// Tells the `sender` that the cancel button is tapped.
  @IBAction private func cancelButtonDidTap(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
}
