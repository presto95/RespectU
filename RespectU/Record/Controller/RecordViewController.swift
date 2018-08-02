//
//  Record2ViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class RecordViewController: GuideRecordBaseViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var buttonBar: ButtonBarView!
    lazy var all = RecordAllTableViewController()
    lazy var portable1 = RecordPortable1TableViewController()
    lazy var portable2 = RecordPortable2TableViewController()
    lazy var respect = RecordRespectTableViewController()
    lazy var trilogy = RecordTrilogyTableViewController()
    lazy var ce = RecordCETableViewController()
    lazy var technika1 = RecordTechnika1TableViewController()
    lazy var bs = RecordBSTableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    static func instantiate() -> RecordViewController? {
        guard let viewController = UIStoryboard(name: "Record", bundle: nil).instantiateViewController(withIdentifier: classNameToString) as? RecordViewController else { return nil }
        return viewController
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [all, portable1, portable2, respect, trilogy, ce, technika1, bs]
    }
    
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}


