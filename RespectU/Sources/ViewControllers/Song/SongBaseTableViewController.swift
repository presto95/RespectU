//
//  SongBaseTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import RealmSwift

/// The base song table view controller.
class SongBaseTableViewController: UITableViewController {
  
  /// The fetched song results.
  var songResults: [SongInfo]?
  
  /// The fetched mission results.
  var missionResults: Results<MissionInfo>?
  
  /// The fetched achievement results.
  var achievementResults: Results<AchievementInfo>?
  
  /// The cell identifier.
  let cellIdentifier = "songCell"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  /// Configures initial settings.
  private func setup() {
    songResults = SongInfo.fetch().sorted { $0.localizedLowercase < $1.localizedLowercase }
    let predicate = NSPredicate(format: "%K LIKE %@",
                                #keyPath(MissionInfo.reward.english),
                                "Music*")
    missionResults = MissionInfo.fetch().filter(predicate)
    achievementResults = AchievementInfo.fetch(byType: .music)
    tableView.rowHeight = 60
    tableView.showsVerticalScrollIndicator = false
    tableView.separatorStyle = .none
    tableView.register(UINib(nibName: SongCell.name, bundle: nil),
                       forCellReuseIdentifier: cellIdentifier)
  }
}

// MARK: - UITableView Configuration

extension SongBaseTableViewController {
  
  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
    cell.contentView.backgroundColor = .clear
    if case let songCell as SongCell = cell {
      let favoriteButton = Persistence.favoriteButton
      let result = songResults?[indexPath.row]
      songCell.configure(with: result, favoriteButton: favoriteButton)
    }
    return cell
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return songResults?.count ?? 0
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    guard let object = songResults?[indexPath.row] else { return }
    var changesSpeed: Bool = false
    let bpm: Int
    if let subBpm = object.subBPM.value {
      bpm = subBpm
      changesSpeed = true
    } else {
      bpm = object.bpm
    }
    let myBPM = Persistence.bpm
    let speed = Utils.convertToRecommendedSpeed(by: myBPM / Double(bpm)) ?? ""
    let unlockAchievement = L10n.unlockACHIEVEMENT
    let unlockMission = L10n.unlockMISSION
    var unlockInfo = ""
    if let bindedAchievementResults = achievementResults {
      for result in bindedAchievementResults where result.localizedItem == object.localizedTitle {
        unlockInfo += "\n\n\(unlockAchievement)\n\(result.localizedSection) Stage \(result.level)"
        break
      }
    }
    if let bindedMissionResults = missionResults {
      for result in bindedMissionResults {
        guard let last = result.localizedReward
          .split(separator: ":").last?.description
          .trimmingCharacters(in: .whitespaces)
          else { return }
        if last == object.localizedTitle {
          unlockInfo += "\n\n\(unlockMission)\n\(result.section) - \(result.title)"
          break
        }
      }
    }
    var message: String = L10n.speedRecommendation + "\n\(speed)" + unlockInfo
    if changesSpeed {
      message += "\n\(L10n.speedVariation)"
    }
    UIAlertController
      .alert(title: object.localizedTitle, message: message)
      .action(title: L10n.ok)
      .present(to: self)
  }
  
  override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
    guard let cell = tableView.cellForRow(at: indexPath) as? SongCell else { return }
    let result = songResults?[indexPath.row]
    let series = result?.seriesEnum ?? .respect
    cell.colorizeSubviews(in: series)
  }
  
  override func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
    guard let cell = tableView.cellForRow(at: indexPath) as? SongCell else { return }
    cell.decolorizeSubviews()
  }
}
