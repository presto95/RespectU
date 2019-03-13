//
//  Record2ViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import XLPagerTabStrip

/// The record view controller.
final class RecordViewController: BaseViewController {
  
  /// The bottom constraint of the scroll view.
  @IBOutlet weak var scrollViewBottomConstraint: NSLayoutConstraint!
  
  /// The scroll view.
  @IBOutlet weak var scrollView: UIScrollView!
  
  /// The table view controller representing the all series.
  private lazy var allTableViewController = RecordAllTableViewController()
  
  /// The table view controller representing the PORTABLE 1 series.
  private lazy var portable1TableViewController = RecordPortable1TableViewController()
  
  /// The table view controller representing the PORTABLE 2 series.
  private lazy var portable2TableViewController = RecordPortable2TableViewController()
  
  /// The table view controller representing the RESPECT series.
  private lazy var respectTableViewController = RecordRespectTableViewController()
  
  /// The table view controller representing the TRILOGY series.
  private lazy var trilogyTableViewController = RecordTrilogyTableViewController()
  
  /// The table view controller representing the CLAZZIQUAI EDITION series.
  private lazy var ceTableViewController = RecordCETableViewController()
  
  /// The table view controller representing the TECHNIKA 1 series.
  private lazy var technika1TableViewController = RecordTechnika1TableViewController()
  
  /// The table view controller representing the BLACK SQUARE series.
  private lazy var bsTableViewController = RecordBSTableViewController()
  
  /// The table view controller representing the TECHNIKA 2 series.
  private lazy var technika2TableViewController = RecordTechnika2TableViewController()
  
  /// The table view controller representing the TECHNIKA 3 series.
  private lazy var technika3TableViewController = RecordTechnika3TableViewController()
  
  override func viewControllers(
    for pagerTabStripController: PagerTabStripViewController
  ) -> [UIViewController] {
    return [
      allTableViewController,
      portable1TableViewController,
      portable2TableViewController,
      respectTableViewController,
      trilogyTableViewController,
      ceTableViewController,
      technika1TableViewController,
      bsTableViewController,
      technika2TableViewController,
      technika3TableViewController
    ]
  }
  
  /// Tells the `sender` that the cancel button is tapped.
  @IBAction private func cancelButtonDidTap(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
}
