//
//  AchievementBaseTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import RealmSwift

class AchievementBaseTableViewController: UITableViewController {
  
  var results: Results<AchievementInfo>?
  
  var stages = [Int]()
  
  let cellIdentifier = "achievementCell"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
  }
  
  private func configure() {
    tableView = UITableView(frame: tableView.bounds, style: .grouped)
    tableView.rowHeight = 40
    tableView.showsVerticalScrollIndicator = false
    tableView.separatorStyle = .none
    tableView.register(UINib(nibName: AchievementCell.name, bundle: nil),
                       forCellReuseIdentifier: cellIdentifier)
  }
}

extension AchievementBaseTableViewController {
  
  func makeNumberOfStages() {
    guard let results = self.results else { return }
    stages.removeAll()
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
  
  func makeAchievementCell(at indexPath: IndexPath, isAll: Bool = false) -> UITableViewCell {
    guard let cell = tableView
      .dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AchievementCell
      else { return UITableViewCell() }
    var rowIndex = 0
    if indexPath.section > 0 {
      for index in 1...indexPath.section {
        rowIndex += stages[index - 1]
      }
    }
    rowIndex += indexPath.row
    let count = self.results?.count ?? 0
    if rowIndex < count {
      let object = self.results?[rowIndex]
      cell.configure(object, isAll: isAll)
    }
    return cell
  }
}

extension AchievementBaseTableViewController {
  
  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return makeAchievementCell(at: indexPath)
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.stages[section]
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return self.stages.count
  }
  
  override func tableView(_ tableView: UITableView,
                          titleForHeaderInSection section: Int) -> String? {
    if section < self.stages.count {
      var index = 0
      for sectionIndex in 0...section {
        index += stages[sectionIndex]
      }
      return self.results?[index - 1].localizedSection
    }
    return nil
  }
  
  override func tableView(_ tableView: UITableView,
                          willDisplayHeaderView view: UIView,
                          forSection section: Int) {
    guard let header = view as? UITableViewHeaderFooterView else { return }
    header.textLabel?.textColor = .black
    header.textLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    header.backgroundView?.backgroundColor = .white
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
