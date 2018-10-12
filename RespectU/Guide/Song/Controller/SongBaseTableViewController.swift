//
//  SongBaseTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import RealmSwift

class SongBaseTableViewController: UITableViewController {

    var songResults: [SongInfo]?
    var missionResults: Results<MissionInfo>?
    var achievementResults: Results<AchievementInfo>?
    var favoriteButton = UserDefaults.standard.string(forKey: "favoriteButton") ?? "4b"
    let myBPM = UserDefaults.standard.double(forKey: "bpm")
    let cellIdentifier = "songCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        songResults = SongInfo.fetch().sorted { $0.localizedLowercase < $1.localizedLowercase }
        let predicate = NSPredicate(format: "%K LIKE %@", #keyPath(MissionInfo.reward.english), "Music*")
        missionResults = MissionInfo.fetch().filter(predicate)
        achievementResults = AchievementInfo.fetch().filter(key: "type", value: "music", method: "=")
        tableView.rowHeight = 60
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "SongCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
}

extension SongBaseTableViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? SongCell else { return UITableViewCell() }
        let object = self.songResults?[indexPath.row]
        cell.setProperties(object, favoriteButton: favoriteButton)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.songResults?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let object = self.songResults?[indexPath.row] else { return }
        var changesSpeed: Bool = false
        let bpm: Int
        if let subBpm = object.subBpm.value {
            bpm = subBpm
            changesSpeed = true
        } else {
            bpm = object.bpm
        }
        let speed = recommendedSpeed(by: myBPM / Double(bpm))
        let unlockAchievement = "Unlock (ACHIEVEMENT)".localized
        let unlockMission = "Unlock (MISSION)".localized
        var unlockInfo = ""
        if let bindedAchievementResults = achievementResults {
            for result in bindedAchievementResults where result.localizedItem == object.localizedTitle {
                unlockInfo += "\n\n\(unlockAchievement)\n\(result.localizedSection) Stage \(result.level)"
                break
            }
        }
        if let bindedMissionResults = missionResults {
            for result in bindedMissionResults {
                guard let last = result.localizedReward.split(separator: ":").last?.description.trimmingCharacters(in: .whitespaces) else { return }
                if last == object.localizedTitle {
                    unlockInfo += "\n\n\(unlockMission)\n\(result.section) - \(result.title)"
                    break
                }
            }
        }
        var message: String = "SPEED Recommendation".localized + "\n\(speed)" + unlockInfo
        if changesSpeed {
            message += "\n" + "(SPEED Variation)".localized
        }
        UIAlertController
            .alert(title: object.localizedTitle, message: message)
            .action(title: "OK".localized)
            .present(to: self)
    }
    
    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? SongCell else { return }
        let object = songResults?[indexPath.row]
        let series = object?.series ?? ""
        cell.setColorsInSong(series, labels: cell.labels)
    }
    
    override func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? SongCell else { return }
        cell.unsetColors(labels: cell.labels)
    }
}
