//
//  AchievementViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import XLPagerTabStrip

/// The achievement view controller.
final class AchievementViewController: ButtonBarPagerTabStripBaseViewController {
  
  /// The table view controller about the all types.
  private lazy var allTableViewController =  AchievementAllTableViewController()
  
  /// The table view controller about the music type.
  private lazy var musicTableViewController = AchievementMusicTableViewController()
  
  /// The table view controller about the gear skin type.
  private lazy var gearTableViewController = AchievementGearTableViewController()
  
  /// The table view controller about the note skin type.
  private lazy var noteTableViewController = AchievementNoteTableViewController()
  
  /// The table view controller about the plate type.
  private lazy var plateTableViewController = AchievementPlateTableViewController()
  
  /// The table view controller about the gallery type.
  private lazy var galleryTableViewController = AchievementGalleryTableViewController()
  
  /// The table view controller about the comment type.
  private lazy var commentTableViewController = AchievementCommentTableViewController()
  
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
  
  /// Tells the `sender` that the cancel button is tapped.
  @IBAction private func cancelButtonDidTap(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
}
