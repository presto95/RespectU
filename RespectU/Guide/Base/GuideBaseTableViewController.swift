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

    var realm: Realm!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.realm = try! Realm()
        self.tableView.emptyDataSetDelegate = self
        self.tableView.emptyDataSetSource = self
        setup()
    }
    
    private func setup() {
        self.view.backgroundColor = .mainColor
        self.tableView.rowHeight = 60
        self.tableView.separatorColor = .mainColor
        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        self.tableView.layer.borderColor = UIColor.mainColor.cgColor
        self.tableView.layer.borderWidth = 3
        self.tableView.layer.cornerRadius = 10
    }
}
