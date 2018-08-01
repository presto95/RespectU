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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    static func instantiate() -> MissionViewController? {
        guard let viewController = UIStoryboard(name: "Mission", bundle: nil).instantiateViewController(withIdentifier: classNameToString) as? MissionViewController else { return nil }
        return viewController
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [MissionRespectTableViewController(), MissionTrilogyTableViewController(), MissionCETableViewController(), MissionTechnika1TableViewController(), MissionBSTableViewController(), MissionLinkDiskTableViewController()]
    }
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
