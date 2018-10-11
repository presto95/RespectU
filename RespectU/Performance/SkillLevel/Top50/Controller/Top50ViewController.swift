//
//  Top50ViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class Top50ViewController: BaseViewController {

    lazy var button4TableViewController = Top504BTableViewController()
    lazy var button5TableViewController = Top505BTableViewController()
    lazy var button6TableViewController = Top506BTableViewController()
    lazy var button8TableViewController = Top508BTableViewController()
    lazy var top50ViewControllers: [Top50BaseTableViewController] = {
        return [button4TableViewController, button5TableViewController, button6TableViewController, button8TableViewController]
    }()
    @IBOutlet weak var sectionView: ButtonBarView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.layer.cornerRadius = 15
        scrollView.layer.borderWidth = 1
        scrollView.layer.borderColor = UIColor.lightGray.cgColor
//        sectionView.layer.cornerRadius = sectionView.bounds.height / 2
//        sectionView.layer.borderWidth = 1
//        sectionView.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return top50ViewControllers
    }
    
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
