//
//  RankingViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class RankingViewController: BaseViewController {

    private lazy var button4TableViewController = Ranking4BTableViewController()
    private lazy var button5TableViewController = Ranking5BTableViewController()
    private lazy var button6TableViewController = Ranking6BTableViewController()
    private lazy var button8TableViewController = Ranking8BTableViewController()
    private lazy var rankingViewControllers: [RankingBaseTableViewController] = {
        return [button4TableViewController, button5TableViewController, button6TableViewController, button8TableViewController]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return rankingViewControllers
    }
    
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
