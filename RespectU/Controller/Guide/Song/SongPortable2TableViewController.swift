//
//  SongPortable2TableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 3..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import RealmSwift
import PMAlertController

class SongPortable2TableViewController: UITableViewController {

    var realm: Realm! = nil
    var results: Results<SongInfo>! = nil
    var achievementResults: Results<AchievementInfo>! = nil
    var missionResults: Results<MissionInfo>! = nil
    
    var favoriteButton = UserDefaults.standard.string(forKey: "favoriteButton") ?? "4B"
    let myBpm = UserDefaults.standard.double(forKey: "bpm")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        results = realm.objects(SongInfo.self).filter("series = 'Portable2'").sorted(byKeyPath: "lowercase")
        achievementResults = realm.objects(AchievementInfo.self).filter("type = 'MUSIC'")
        missionResults = realm.objects(MissionInfo.self).filter("reward LIKE 'Music*'")
        
        view.backgroundColor = UIColor.mainColor
        tableView.rowHeight = 60
        tableView.separatorColor = UIColor.mainColor
        tableView.layer.borderColor = UIColor.mainColor.cgColor
        tableView.layer.borderWidth = 3
        tableView.layer.cornerRadius = 10
        tableView.register(UINib(nibName: "SongCell", bundle: nil), forCellReuseIdentifier: "songCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell") as! SongCell
        let object = results[indexPath.row]
        cell.color.backgroundColor = UIColor.portable2
        cell.title.text = object.title
        cell.artist.text = object.composer
        cell.bpm.text = "BPM " + object.bpm
        switch(favoriteButton){
        case "4B":
            cell.nm.text = object.nm4 == 0 ? "-" : String(object.nm4)
            cell.hd.text = object.hd4 == 0 ? "-" : String(object.hd4)
            cell.mx.text = object.mx4 == 0 ? "-" : String(object.mx4)
        case "5B":
            cell.nm.text = object.nm5 == 0 ? "-" : String(object.nm5)
            cell.hd.text = object.hd5 == 0 ? "-" : String(object.hd5)
            cell.mx.text = object.mx5 == 0 ? "-" : String(object.mx5)
        case "6B":
            cell.nm.text = object.nm6 == 0 ? "-" : String(object.nm6)
            cell.hd.text = object.hd6 == 0 ? "-" : String(object.hd6)
            cell.mx.text = object.mx6 == 0 ? "-" : String(object.mx6)
        case "8B":
            cell.nm.text = object.nm8 == 0 ? "-" : String(object.nm8)
            cell.hd.text = object.hd8 == 0 ? "-" : String(object.hd8)
            cell.mx.text = object.mx8 == 0 ? "-" : String(object.mx8)
        default:
            break
        }
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let object = results[indexPath.row]
        let recommendedSpeed = String.decideSpeed(speed: myBpm / Double.convertBpmToDouble(string: object.bpm))
        var unlockInfo = ""
        for content in achievementResults{
            if(content.item == object.title){
                unlockInfo += "\n\n" + "Unlock (ACHIEVEMENT)".localized + "\n" + content.title.localized + " Stage \(content.level)"
                break
            }
        }
        for content in missionResults{
            if(content.reward.localized.split(separator: ":").last!.trimmingCharacters(in: .whitespaces) == object.title){
                unlockInfo += "\n\n" + "Unlock (MISSION)".localized + "\n" + content.section + " - " + content.title
                break
            }
        }
        let message = "SPEED Recommendation".localized + "\n\(recommendedSpeed)" + unlockInfo
        let alert = UIAlertController.showOKAndAddFavorite(title: object.title, message: message, object: object)
        present(alert, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
}

extension SongPortable2TableViewController: IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "PORTABLE 2")
    }
}
