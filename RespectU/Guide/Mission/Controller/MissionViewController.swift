//
//  MissionViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class MissionViewController: BaseViewController {

    private lazy var respectTableViewController = MissionRespectTableViewController()
    private lazy var trilogyTableViewController = MissionTrilogyTableViewController()
    private lazy var ceTableViewController = MissionCETableViewController()
    private lazy var technika1TableViewController = MissionTechnika1TableViewController()
    private lazy var bsTableViewController = MissionBSTableViewController()
    private lazy var linkDiskTableViewController = MissionLinkDiskTableViewController()
    private lazy var technika2TableViewController = MissionTechnika2TableViewController()
    lazy var missionViewControllers: [MissionBaseTableViewController] = {
        return [respectTableViewController, trilogyTableViewController, ceTableViewController, technika1TableViewController, bsTableViewController, linkDiskTableViewController, technika2TableViewController]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return missionViewControllers
    }
    
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
