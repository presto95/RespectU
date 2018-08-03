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
    
    lazy var all = AchievementAllTableViewController()
    lazy var music = AchievementMusicTableViewController()
    lazy var gear = AchievementGearTableViewController()
    lazy var note = AchievementNoteTableViewController()
    lazy var plate = AchievementPlateTableViewController()
    lazy var gallery = AchievementGalleryTableViewController()
    lazy var comment = AchievementCommentTableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    static func instantiate() -> AchievementViewController? {
        guard let viewController = UIStoryboard(name: "Achievement", bundle: nil).instantiateViewController(withIdentifier: classNameToString) as? AchievementViewController else { return nil }
        return viewController
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [all, music, gear, note, plate, gallery, comment]
    }
    
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
