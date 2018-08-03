
//
//  Top50BaseTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 3..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import RealmSwift

class Top50BaseTableViewController: BaseTableViewController {

    var results: Results<RecordInfo>!
    let cellIdentifier = "top50Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "Top50Cell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? Top50Cell else { return UITableViewCell() }
        let object = results[indexPath.row]
        cell.setProperties(object, button: Buttons.button4)
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
}
