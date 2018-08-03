//
//  DetailBaseViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class BaseTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        self.view.backgroundColor = .main
        self.tableView.separatorColor = .main
        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        self.tableView.layer.borderColor = UIColor.main.cgColor
        self.tableView.layer.borderWidth = 3
        self.tableView.layer.cornerRadius = 10
    }
}
