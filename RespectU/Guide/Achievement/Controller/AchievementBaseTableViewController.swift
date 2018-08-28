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
        showIndicator()
        self.tableView.rowHeight = 40
        tableView.register(UINib(nibName: "AchievementCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveAchievements(_:)), name: .didReceiveAchievements, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(errorReceiveAchievements(_:)), name: .errorReceiveAchievements, object: nil)
    }
    
    @objc func didReceiveAchievements(_ notification: Notification) {
        guard let userInfo = notification.userInfo?["achievements"] as? AchievementResponse else { return }
        self.results = userInfo
        generateStageCounts()
        DispatchQueue.main.async { [weak self] in
            self?.hideIndicator()
            self?.tableView.reloadData()
        }
        NotificationCenter.default.removeObserver(self, name: .didReceiveAchievements, object: nil)
    }
    
    @objc func errorReceiveAchievements(_ notification: Notification) {
        guard let error = notification.userInfo?["error"] as? String else { return }
        UIAlertController
            .alert(title: "", message: error)
            .defaultAction(title: "OK".localized) { [weak self] _ in
                self?.hideIndicator()
                self?.parent?.dismiss(animated: true, completion: nil)
            }
            .present(to: self)
    }
}

extension AchievementBaseTableViewController {
    func generateStageCounts() {
        guard let results = self.results else { return }
        self.stages.removeAll()
        var count = 0
        var tempTitle = ""
        var isFirst = true
        for item in results.achievements {
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
    
    func achievementCell(at indexPath: IndexPath, isAll: Bool = false) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? AchievementCell else { return UITableViewCell() }
        var rowIndex = 0
        if indexPath.section > 0 {
            for i in 1...indexPath.section {
                rowIndex += stages[i - 1]
            }
        }
        rowIndex += indexPath.row
        let count = self.results?.count ?? 0
        if rowIndex < count {
            let object = self.results?[rowIndex]
            cell.setProperties(object, isAll: isAll)
        }
        return cell
    }
}

extension AchievementBaseTableViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return achievementCell(at: indexPath)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stages[section]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.stages.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < self.stages.count {
            var index = 0
            for i in 0...section {
                index += stages[i]
            }
            return self.results?[index - 1].localizedSection
        }
        return nil
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
