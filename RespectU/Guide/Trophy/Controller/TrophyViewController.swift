//
//  TrophyViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class TrophyViewController: GuideBaseViewController {

    lazy var respect = TrophyRespectTableViewController()
    lazy var trilogy = TrophyTrilogyTableViewController()
    lazy var ce = TrophyCETableViewController()
    lazy var technika1 = TrophyTechnika1TableViewController()
    lazy var bs = TrophyBSTableViewController()
    lazy var linkDisk = TrophyLinkDiskTableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    static func instantiate() -> TrophyViewController? {
        guard let viewController = UIStoryboard(name: "Trophy", bundle: nil).instantiateViewController(withIdentifier: classNameToString) as? TrophyViewController else { return nil }
        return viewController
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [respect, trilogy, ce, technika1, bs, linkDisk]
    }
    
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
