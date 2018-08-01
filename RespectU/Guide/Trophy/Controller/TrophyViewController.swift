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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    static func instantiate() -> TrophyViewController? {
        guard let viewController = UIStoryboard(name: "Trophy", bundle: nil).instantiateViewController(withIdentifier: classNameToString) as? TrophyViewController else { return nil }
        return viewController
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [TrophyRespectTableViewController(), TrophyTrilogyTableViewController(), TrophyCETableViewController(), TrophyTechnika1TableViewController(), TrophyBSTableViewController(), TrophyLinkDiskTableViewController()]
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
