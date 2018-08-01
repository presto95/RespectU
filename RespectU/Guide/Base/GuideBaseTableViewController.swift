//
//  DetailBaseViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import RealmSwift
import XLPagerTabStrip

class GuideBaseTableViewController: UITableViewController {

    var realm: Realm! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.realm = try! Realm()
        self.tableView.emptyDataSetDelegate = self
        self.tableView.emptyDataSetSource = self
        setup()
    }
    
    private func setup() {
        view.backgroundColor = UIColor.mainColor
        tableView.rowHeight = 60
        tableView.separatorColor = UIColor.mainColor
        tableView.layer.borderColor = UIColor.mainColor.cgColor
        tableView.layer.borderWidth = 3
        tableView.layer.cornerRadius = 10
    }
}
