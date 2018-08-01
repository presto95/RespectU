//
//  Record2ViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class RecordViewController: ButtonBarPagerTabStripViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var buttonBar: ButtonBarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settings.style.buttonBarBackgroundColor = UIColor.subColor
        settings.style.buttonBarItemBackgroundColor = UIColor.subColor
        settings.style.selectedBarBackgroundColor = UIColor.mainColor
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        settings.style.buttonBarItemFont = UIFont.systemFont(ofSize: 14, weight: .medium)
        // Do any additional setup after loading the view.
    }

    static func instantiate() -> RecordViewController? {
        guard let viewController = UIStoryboard(name: "Record", bundle: nil).instantiateViewController(withIdentifier: classNameToString) as? RecordViewController else { return nil }
        return viewController
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [RecordAllTableViewController(), RecordPortable1TableViewController(), RecordPortable2TableViewController(), RecordRespectTableViewController(), RecordTrilogyTableViewController(), RecordCETableViewController(), RecordTechnika1TableViewController(), RecordBSTableViewController()]
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}


