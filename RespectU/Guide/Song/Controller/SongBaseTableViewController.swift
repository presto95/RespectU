//
//  SongBaseTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import RealmSwift

class SongBaseTableViewController: BaseTableViewController {

    var songResults: [SongResponse.Song]?
    var achievementResults: AchievementResponse?
    var missionResults: MissionResponse?
    var favoriteButton = UserDefaults.standard.string(forKey: "favoriteButton") ?? "4B"
    let myBPM = UserDefaults.standard.double(forKey: "bpm")
    let cellIdentifier = "songCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 60
        self.tableView.register(UINib(nibName: "SongCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        //도전과제 : type == music
        //미션 : reward == music
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveSongs(_:)), name: .didReceiveSongs, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showIndicator()
    }
    
    @objc func didReceiveSongs(_ notification: Notification) {
        guard let userInfo = notification.userInfo?["songs"] as? SongResponse else { return }
        let sorted = userInfo.song.sorted { $0.localizedLowercase < $1.localizedLowercase }
        self.songResults = sorted
        DispatchQueue.main.async { [weak self] in
            self?.hideIndicator()
            self?.tableView.reloadData()
        }
    }
}

extension SongBaseTableViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? SongCell else { return UITableViewCell() }
        let object = songResults?[indexPath.row]
        cell.setProperties(object, favoriteButton: favoriteButton)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.songResults?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        let object = self.songResults?[indexPath.row]
//        let speed = recommendedSpeed(by: myBPM / object.bpm.bpmToDouble)
//        let unlockAchievement = "Unlock (ACHIEVEMENT)".localized
//        let unlockMission = "Unlock (MISSION)".localized
//        var unlockInfo = ""
//        for result in achievementResults {
//            if result.item == object.title {
//                unlockInfo += "\n\n\(unlockAchievement)\n\(result.title.localized) Stage \(result.level)"
//                break
//            }
//        }
//        for result in missionResults {
//            guard let last = result.reward.localized.split(separator: ":").last?.description.trimmingCharacters(in: .whitespaces) else { return }
//            if last == object.title {
//                unlockInfo += "\n\n\(unlockMission)\n\(result.section) - \(result.title)"
//                break
//            }
//        }
//        let message = "SPEED Recommendation".localized + "\n\(speed)" + unlockInfo
//        UIAlertController
//            .alert(title: object.title, message: message)
//            .defaultAction(title: "Add to Favorite".localized) { action in
//                let query = NSPredicate(format: "title = %@", object.title)
//                if PlaylistInfo.get().filter(query).isEmpty {
//                    PlaylistInfo.add(series: object.series, title: object.title, composer: object.composer, bpm: object.bpm, nm4: object.nm4, hd4: object.hd4, mx4: object.mx4, nm5: object.nm5, hd5: object.hd5, mx5: object.mx5, nm6: object.nm6, hd6: object.hd6, mx6: object.mx6, nm8: object.nm8, hd8: object.hd8, mx8: object.mx8)
//                }
//            }
//            .cancelAction(title: "OK".localized)
//            .present(to: self)
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
