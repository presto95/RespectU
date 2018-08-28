//
//  MissionBaseTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import RealmSwift

class MissionBaseTableViewController: BaseTableViewController {

    var results: MissionResponse?
    let cellIdentifier = "missionCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showIndicator()
        self.tableView.rowHeight = 60
        self.tableView.register(UINib(nibName: "MissionCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveMissions(_:)), name: .didReceiveMissions, object: nil)
    }
    
    @objc func didReceiveMissions(_ notification: Notification) {
        guard let userInfo = notification.userInfo?["missions"] as? MissionResponse else { return }
        self.results = userInfo
        DispatchQueue.main.async { [weak self] in
            self?.hideIndicator()
            self?.tableView.reloadData()
        }
        NotificationCenter.default.removeObserver(self, name: .didReceiveMissions, object: nil)
    }
}

extension MissionBaseTableViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? MissionCell else { return UITableViewCell() }
        let object = self.results?[indexPath.row + indexPath.section * 6]
        cell.setProperties(object)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let object = self.results?[indexPath.row + indexPath.section * 6]
        let detailViewController = MissionDetailViewController.instantiate(object)!
        detailViewController.modalTransitionStyle = .crossDissolve
        self.present(detailViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return (self.results?.count ?? 0) / 6
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.results?[section * 6].section
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = .white
        header.textLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        header.backgroundView?.backgroundColor = .main
    }
    
    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? MissionCell else { return }
        guard let object = self.results?[indexPath.row + indexPath.section * 6] else { return }
        cell.setColorsInMission(object.section, labels: cell.labels)
    }
    
    override func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? MissionCell else { return }
        cell.unsetColors(labels: cell.labels)
    }
}
