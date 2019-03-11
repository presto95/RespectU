//
//  TrophyViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import XLPagerTabStrip

final class TrophyViewController: BaseViewController {
  
  private lazy var respectTableViewController = TrophyRespectTableViewController()
  
  private lazy var trilogyTableViewController = TrophyTrilogyTableViewController()
  
  private lazy var ceTableViewController = TrophyCETableViewController()
  
  private lazy var technika1TableViewController = TrophyTechnika1TableViewController()
  
  private lazy var bsTableViewController = TrophyBSTableViewController()
  
  private lazy var linkDiskTableViewController = TrophyLinkDiskTableViewController()
  
  private lazy var technika2TableViewController = TrophyTechnika2TableViewController()
  
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
  
  @IBAction func cancelButtonDidTap(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
}
