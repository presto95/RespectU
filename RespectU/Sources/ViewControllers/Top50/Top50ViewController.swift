//
//  Top50ViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import XLPagerTabStrip

final class Top50ViewController: BaseViewController {
  
  private lazy var button4TableViewController = Top504BTableViewController()
  
  private lazy var button5TableViewController = Top505BTableViewController()
  
  private lazy var button6TableViewController = Top506BTableViewController()
  
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
  
  @IBAction private func cancelButtonDidTap(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
}
