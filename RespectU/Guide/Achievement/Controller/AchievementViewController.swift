//
//  AchievementViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class AchievementViewController: GuideBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    static func instantiate() -> AchievementViewController? {
        guard let viewController = UIStoryboard(name: "Achievement", bundle: nil).instantiateViewController(withIdentifier: classNameToString) as? AchievementViewController else { return nil }
        return viewController
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [AchievementAllTableViewController(), AchievementMusicTableViewController(), AchievementGearTableViewController(), AchievementNoteTableViewController(), AchievementPlateTableViewController(), AchievementGalleryTableViewController(), AchievementCommentTableViewController()]
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
