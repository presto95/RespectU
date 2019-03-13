//
//  AchievementBaseTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import RealmSwift

/// The achievement base table view controller.
class AchievementBaseTableViewController: UITableViewController {
  
  /// The fetched achievement results.
  var results: Results<AchievementInfo>?
  
  /// The stages by section.
  var stages = [Int]()
  
  /// The cell identifier.
  let cellIdentifier = "achievementCell"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
  }
  
  /// Configures initial settings.
  private func configure() {
    tableView = UITableView(frame: tableView.bounds, style: .grouped).then {
      $0.rowHeight = 40
      $0.showsVerticalScrollIndicator = false
      $0.separatorStyle = .none
      $0.register(UINib(nibName: AchievementCell.name, bundle: nil),
                  forCellReuseIdentifier: cellIdentifier)
    }
  }
  
  /// Makes number of stages.
  func makeNumberOfStages() {
    guard let results = results else { return }
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
  
  /// Makes achievement cell at `indexPath`.
  ///
  /// - Parameters:
  ///   - indexPath:  The index path of the made cell.
  ///   - isAll:      The boolean value indicating whether the type is all.
  ///                 The default value is `false`.
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
    let count = results?.count ?? 0
    if rowIndex < count {
      let object = results?[rowIndex]
      cell.configure(with: object, isAll: isAll)
    }
    return cell
  }
}

// MARK: - UITableView Configuration

extension AchievementBaseTableViewController {
  
  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return makeAchievementCell(at: indexPath)
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return stages[section]
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return stages.count
  }
  
  override func tableView(_ tableView: UITableView,
                          titleForHeaderInSection section: Int) -> String? {
    if section < stages.count {
      var index = 0
      for sectionIndex in 0...section {
        index += stages[sectionIndex]
      }
      return results?[index - 1].localizedSection
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
