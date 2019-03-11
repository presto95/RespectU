//
//  AchievementViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import XLPagerTabStrip

final class AchievementViewController: BaseViewController {
  
  private lazy var allTableViewController =  AchievementAllTableViewController()
  
  private lazy var musicTableViewController = AchievementMusicTableViewController()
  
  private lazy var gearTableViewController = AchievementGearTableViewController()
  
  private lazy var noteTableViewController = AchievementNoteTableViewController()
  
  private lazy var plateTableViewController = AchievementPlateTableViewController()
  
  private lazy var galleryTableViewController = AchievementGalleryTableViewController()
  
  private lazy var commentTableViewController = AchievementCommentTableViewController()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewControllers(
    for pagerTabStripController: PagerTabStripViewController
  ) -> [UIViewController] {
    return [
      allTableViewController,
      musicTableViewController,
      gearTableViewController,
      noteTableViewController,
      plateTableViewController,
      galleryTableViewController,
      commentTableViewController
    ]
  }
  
  @IBAction func cancelButtonDidTap(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
}
