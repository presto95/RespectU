//
//  RecordBaseTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import RealmSwift

class RecordBaseTableViewController: BaseTableViewController {

    let favoriteButton = UserDefaults.standard.string(forKey: "favoriteButton") ?? "4B"
    var results: Results<RecordInfo>!
    let cellIdentifier = "recordCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "RecordCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let recordViewController = self.parent as? RecordViewController else { return }
        let lastSubview = recordViewController.view.subviews.last
        if lastSubview is RecordView {
            recordViewController.scrollViewBottomConstraint.constant += 200
            lastSubview?.removeFromSuperview()
        }
        if let selectedIndexPath = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: selectedIndexPath, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RecordCell else { return UITableViewCell() }
        let object = self.results[indexPath.row]
        cell.setProperties(object)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.results.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? RecordCell else { return }
        guard let recordViewController = self.parent as? RecordViewController else { return }
        let title = cell.titleLabel.text ?? ""
        let lastSubview = recordViewController.view.subviews.last
        if lastSubview is RecordView {
            lastSubview?.removeFromSuperview()
        } else {
            recordViewController.scrollViewBottomConstraint.constant -= 200
        }
        guard let recordView = RecordView.instanceFromXib(title: title, tableViewController: self) as? RecordView else { return }
        recordView.frame = CGRect(x: 0, y: recordViewController.view.bounds.height - 210, width: recordViewController.view.bounds.width, height: 200)
        recordViewController.view.addSubview(recordView)
    }
}
