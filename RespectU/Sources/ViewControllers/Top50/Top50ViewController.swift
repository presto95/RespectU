//
//  Top50ViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import XLPagerTabStrip

/// The top50 view controller.
final class Top50ViewController: ButtonBarPagerTabStripBaseViewController {
  
  /// The table view about the 4B.
  private lazy var button4TableViewController = Top504BTableViewController()
  
  /// The table view about the 5B.
  private lazy var button5TableViewController = Top505BTableViewController()
  
  /// The table view about the 6B.
  private lazy var button6TableViewController = Top506BTableViewController()
  
  /// The table view about the 8B.
  private lazy var button8TableViewController = Top508BTableViewController()
  
  override func viewControllers(
    for pagerTabStripController: PagerTabStripViewController
  ) -> [UIViewController] {
    return [
      button4TableViewController,
      button5TableViewController,
      button6TableViewController,
      button8TableViewController
    ]
  }
  
  /// Tells the `sender` that the cancel button is tapped.
  @IBAction private func cancelButtonDidTap(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
}
