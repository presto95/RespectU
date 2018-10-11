//
//  Record2ViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class RecordViewController: BaseViewController {
    
    @IBOutlet weak var scrollViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var buttonBar: ButtonBarView!
    private lazy var allTableViewController = RecordAllTableViewController()
    private lazy var portable1TableViewController = RecordPortable1TableViewController()
    private lazy var portable2TableViewController = RecordPortable2TableViewController()
    private lazy var respectTableViewController = RecordRespectTableViewController()
    private lazy var trilogyTableViewController = RecordTrilogyTableViewController()
    private lazy var ceTableViewController = RecordCETableViewController()
    private lazy var technika1TableViewController = RecordTechnika1TableViewController()
    private lazy var bsTableViewController = RecordBSTableViewController()
    private lazy var technika2TableViewController = RecordTechnika2TableViewController()
    lazy var recordViewControllers: [RecordBaseTableViewController] = {
        return [allTableViewController, portable1TableViewController, portable2TableViewController, respectTableViewController, trilogyTableViewController, ceTableViewController, technika1TableViewController, bsTableViewController, technika2TableViewController]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return recordViewControllers
    }
    
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
