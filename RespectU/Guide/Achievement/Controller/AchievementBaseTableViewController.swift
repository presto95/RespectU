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

    var results: Results<AchievementInfo>?
    var stages = [Int]()
    let cellIdentifier = "achievementCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 40
        tableView.register(UINib(nibName: "AchievementCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
}

extension AchievementBaseTableViewController {
    func generateStageCounts() {
        guard let results = self.results else { return }
        self.stages.removeAll()
        var count = 0
        var tempTitle = ""
        var isFirst = true
        for result in results {
            if tempTitle != result.localizedSection {
                tempTitle = result.localizedSection
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
