//
//  AchievementViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class AchievementViewController: BaseViewController {
    
    private lazy var allTableViewController =  AchievementAllTableViewController()
    private lazy var musicTableViewController = AchievementMusicTableViewController()
    private lazy var gearTableViewController = AchievementGearTableViewController()
    private lazy var noteTableViewController = AchievementNoteTableViewController()
    private lazy var plateTableViewController = AchievementPlateTableViewController()
    private lazy var galleryTableViewController = AchievementGalleryTableViewController()
    private lazy var commentTableViewController = AchievementCommentTableViewController()
    lazy var achievementViewControllers: [AchievementBaseTableViewController] = {
        return [allTableViewController, musicTableViewController, gearTableViewController, noteTableViewController, plateTableViewController, galleryTableViewController, commentTableViewController]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return achievementViewControllers
    }
    
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
