//
//  TrophyViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class TrophyViewController: BaseViewController {

    private lazy var respectTableViewController = TrophyRespectTableViewController()
    private lazy var trilogyTableViewController = TrophyTrilogyTableViewController()
    private lazy var ceTableViewController = TrophyCETableViewController()
    private lazy var technika1TableViewController = TrophyTechnika1TableViewController()
    private lazy var bsTableViewController = TrophyBSTableViewController()
    private lazy var linkDiskTableViewController = TrophyLinkDiskTableViewController()
    private lazy var technika2TableViewController = TrophyTechnika2TableViewController()
    lazy var trophyViewControllers: [TrophyBaseTableViewController] = {
        return [respectTableViewController, trilogyTableViewController, ceTableViewController, technika1TableViewController, bsTableViewController, linkDiskTableViewController, technika2TableViewController]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return trophyViewControllers
    }
    
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
