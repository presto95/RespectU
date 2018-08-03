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
    lazy var trophyViewControllers: [TrophyBaseTableViewController] = {
        return [respectTableViewController, trilogyTableViewController, ceTableViewController, technika1TableViewController, bsTableViewController, linkDiskTableViewController]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    static func instantiate() -> TrophyViewController? {
        guard let viewController = UIStoryboard(name: "Trophy", bundle: nil).instantiateViewController(withIdentifier: classNameToString) as? TrophyViewController else { return nil }
        return viewController
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return trophyViewControllers
    }
    
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
