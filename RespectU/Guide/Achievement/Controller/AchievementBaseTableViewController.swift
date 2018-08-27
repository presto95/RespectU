//
//  AchievementBaseTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import RealmSwift

class AchievementBaseTableViewController: BaseTableViewController {

    var results: AchievementResponse?
    var stages = [Int]()
    let cellIdentifier = "achievementCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 40
        tableView.register(UINib(nibName: "AchievementCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveAchievements(_:)), name: .didReceiveAchievements, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showIndicator()
    }
    
    @objc func didReceiveAchievements(_ notification: Notification) {
        guard let userInfo = notification.userInfo?["achievements"] as? AchievementResponse else { return }
        self.results = userInfo
        generateStageCounts()
        DispatchQueue.main.async { [weak self] in
            self?.hideIndicator()
            self?.tableView.reloadData()
        }
    }
}

extension AchievementBaseTableViewController {
    func generateStageCounts() {
        guard let results = self.results else { return }
        self.stages.removeAll()
        var count = 0
        var tempTitle = ""
        var isFirst = true
        for item in results.achievement {
            if tempTitle != item.section.english {
                tempTitle = item.section.english
                if isFirst {
                    isFirst = false
                } else {
                    stages.append(count)
                    count = 0
                }
            }
            count += 1
        }
        stages.append(count)
    }
}

extension AchievementBaseTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stages[section]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.stages.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var index = 0
        for i in 0...section {
            index += stages[i]
        }
        let sectionTitle = self.results?[index - 1].section
        return regionCode == "KR" ? sectionTitle?.korean : sectionTitle?.english
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = .white
        header.textLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        header.backgroundView?.backgroundColor = .main
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
