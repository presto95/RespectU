//
//  MissionViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class MissionViewController: GuideBaseViewController {

    lazy var respect = MissionRespectTableViewController()
    lazy var trilogy = MissionTrilogyTableViewController()
    lazy var ce = MissionCETableViewController()
    lazy var technika1 = MissionTechnika1TableViewController()
    lazy var bs = MissionBSTableViewController()
    lazy var linkDisk = MissionLinkDiskTableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    static func instantiate() -> MissionViewController? {
        guard let viewController = UIStoryboard(name: "Mission", bundle: nil).instantiateViewController(withIdentifier: classNameToString) as? MissionViewController else { return nil }
        return viewController
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [respect, trilogy, ce, technika1, bs, linkDisk]
    }
    
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
