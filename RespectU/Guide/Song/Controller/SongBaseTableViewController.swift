//
//  SongBaseTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import RealmSwift

class SongBaseTableViewController: GuideBaseTableViewController {

    var songResults: Results<SongInfo>! = nil
    var achievementResults: Results<AchievementInfo>! = nil
    var missionResults: Results<MissionInfo>! = nil
    var favoriteButton = UserDefaults.standard.string(forKey: "favoriteButton") ?? "4B"
    let myBPM = UserDefaults.standard.double(forKey: "bpm")
    let cellIdentifier = "songCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "SongCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)        
        self.achievementResults = realm.objects(AchievementInfo.self).filter("type = 'MUSIC'")
        self.missionResults = realm.objects(MissionInfo.self).filter("reward LIKE 'Music*'")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? SongCell else { return UITableViewCell() }
        let object = songResults[indexPath.row]
        cell.setProperties(object, favoriteButton: favoriteButton)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let object = songResults[indexPath.row]
        let recommendedSpeed = getRecommendedSpeed(speed: myBPM / object.bpm.bpmToDouble)
        let unlockAchievement = "Unlock (ACHIEVEMENT".localized
        let unlockMission = "Unlock (MISSION)".localized
        var unlockInfo = ""
        for result in achievementResults {
            if result.item == object.title {
                unlockInfo += "\n\n\(unlockAchievement)\n\(result.title.localized) Stage \(result.level)"
                break
            }
        }
        for result in missionResults {
            guard let last = result.reward.localized.split(separator: ":").last?.description.trimmingCharacters(in: .whitespaces) else { return }
            if last == object.title {
                unlockInfo += "\n\n\(unlockMission)\n\(result.section) - \(result.title)"
                break
            }
        }
        let message = "SPEED Recommendation".localized + "\n\(recommendedSpeed)" + unlockInfo
        UIAlertController
            .alert(title: object.title, message: message)
            .defaultAction(title: "Add to Favorite".localized) { [unowned self] action in
                let query = NSPredicate(format: "title = %@", object.title)
                if self.realm.objects(PlaylistInfo.self).filter(query).isEmpty {
                    PlaylistInfo.add(series: object.series, title: object.title, composer: object.composer, bpm: object.bpm, nm4: object.nm4, hd4: object.hd4, mx4: object.mx4, nm5: object.nm5, hd5: object.hd5, mx5: object.mx5, nm6: object.nm6, hd6: object.hd6, mx6: object.mx6, nm8: object.nm8, hd8: object.hd8, mx8: object.mx8)
                }
            }
            .cancelAction(title: "OK".localized)
            .present(to: self)
    }
}
