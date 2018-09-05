//
//  DownloadViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 29..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class DownloadViewController: UIViewController {

    @IBOutlet weak var downloadDataLabel: UILabel!
    @IBOutlet weak var downloadDataButton: UIButton!
    @IBOutlet weak var downloadRecordLabel: UILabel!
    @IBOutlet weak var downloadRecordButton: UIButton!
    var finishesSong: Bool = false
    var finishesMission: Bool = false
    var finishesTrophy: Bool = false
    var finishesAchievement: Bool = false
    var finishesTip: Bool = false
    var finishesVersion: Bool = false
    var finishesRecord: Bool = false
    var dataCount = 0 {
        didSet {
            if dataCount == 6 {
                hideIndicator()
                if finishesDataAll {
                    presentSuccessAlert()
                } else {
                    presentFailureAlert()
                }
                dataCount = 0
            }
        }
    }
    var recordCount = 0 {
        didSet {
            if recordCount == 1 {
                hideIndicator()
                if finishesRecord {
                    presentSuccessAlert()
                } else {
                    presentFailureAlert()
                }
                recordCount = 0
            }
        }
    }
    var finishesDataAll: Bool {
        if finishesSong, finishesMission, finishesTrophy, finishesAchievement, finishesTip, finishesVersion {
            return true
        }
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.downloadDataButton.layer.cornerRadius = 10
        self.downloadDataButton.backgroundColor = .main
        self.downloadRecordButton.layer.cornerRadius = 10
        self.downloadRecordButton.backgroundColor = .main
        self.downloadDataLabel.text = "Update with latest data.".localized
        self.downloadRecordLabel.text = "Get exported performance record data.".localized
        self.downloadDataButton.setTitle("Download".localized, for: [])
        self.downloadRecordButton.setTitle("Download".localized, for: [])
        self.downloadDataButton.addTarget(self, action: #selector(touchUpDownloadDataButton(_:)), for: .touchUpInside)
        self.downloadRecordButton.addTarget(self, action: #selector(touchUpDownloadRecordButton(_:)), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveSongs(_:)), name: .didReceiveSongs, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveMissions(_:)), name: .didReceiveMissions, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveTrophies(_:)), name: .didReceiveTrophies, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveAchievements(_:)), name: .didReceiveAchievements, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveTips(_:)), name: .didReceiveTips, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveVersions(_:)), name: .didReceiveVersions, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(errorReceiveSongs(_:)), name: .errorReceiveSongs, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(errorReceiveMissions(_:)), name: .errorReceiveMissions, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(errorReceiveTrophies(_:)), name: .errorReceiveTrophies, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(errorReceiveAchievements(_:)), name: .errorReceiveAchievements, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(errorReceiveTips(_:)), name: .errorReceiveTips, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(errorReceiveVersions(_:)), name: .errorReceiveVersions, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveRecords(_:)), name: .didReceiveRequestRecords, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(errorReceiveRecords(_:)), name: .errorReceiveRequestRecords, object: nil)
    }
    
    @objc func touchUpDownloadDataButton(_ sender: UIButton) {
        showIndicator()
        API.requestSongs()
        API.requestMissions()
        API.requestTrophies()
        API.requestAchievements()
        API.requestTips()
        API.requestVersions()
    }
    
    @objc func touchUpDownloadRecordButton(_ sender: UIButton) {
        UIAlertController
            .alert(title: "", message: "Coming soon.".localized)
            .action(title: "OK".localized)
            .present(to: self)
//        UIAlertController
//            .alert(title: "Warning".localized, message: "If there is no data on the server, the recorded performance information can be initialized.".localized)
//            .action(.destructive, title: "OK".localized, handler: { [weak self] _ in
//                if KeychainWrapper.standard.string(forKey: "id") == nil {
//                    UIAlertController
//                        .alert(title: "", message: "Log In First.".localized)
//                        .action(title: "OK".localized)
//                        .present(to: self)
//                } else {
//                    DispatchQueue.main.async {
//                        self?.showIndicator()
//                    }
//                    API.requestRecords()
//                }
//            })
//            .action(.cancel, title: "Cancel".localized)
//            .present(to: self)
    }
    
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension DownloadViewController {
    @objc func didReceiveSongs(_ notification: Notification) {
        guard let userInfo = notification.userInfo?["songs"] as? SongResponse else { return }
        let downloadedSongs = userInfo.songs
        let results = SongInfo.fetch()
        for downloadedSong in downloadedSongs {
            let predicate = NSPredicate(format: "%K == %@", #keyPath(SongInfo.title.english), downloadedSong.title.english)
            if let result = results.filter(predicate).first {
                SongInfo.update(downloadedSong, to: result)
            } else {
                SongInfo.add(downloadedSong)
                let recordInfo = NewRecordInfo()
                recordInfo.title?.english = downloadedSong.title.english
                recordInfo.title?.korean = downloadedSong.title.korean
                recordInfo.series = downloadedSong.series
                let button4Record = NewRecordButtonInfo()
                let button5Record = NewRecordButtonInfo()
                let button6Record = NewRecordButtonInfo()
                let button8Record = NewRecordButtonInfo()
                let button4NormalRecord = NewRecordDifficultyInfo()
                let button4HardRecord = NewRecordDifficultyInfo()
                let button4MaximumRecord = NewRecordDifficultyInfo()
                let button5NormalRecord = NewRecordDifficultyInfo()
                let button5HardRecord = NewRecordDifficultyInfo()
                let button5MaximumRecord = NewRecordDifficultyInfo()
                let button6NormalRecord = NewRecordDifficultyInfo()
                let button6HardRecord = NewRecordDifficultyInfo()
                let button6MaximumRecord = NewRecordDifficultyInfo()
                let button8NormalRecord = NewRecordDifficultyInfo()
                let button8HardRecord = NewRecordDifficultyInfo()
                let button8MaximumRecord = NewRecordDifficultyInfo()
                button4Record.normal = button4NormalRecord
                button4Record.hard = button4HardRecord
                button4Record.maximum = button4MaximumRecord
                button5Record.normal = button5NormalRecord
                button5Record.hard = button5HardRecord
                button5Record.maximum = button5MaximumRecord
                button6Record.normal = button6NormalRecord
                button6Record.hard = button6HardRecord
                button6Record.maximum = button6MaximumRecord
                button8Record.normal = button8NormalRecord
                button8Record.hard = button8HardRecord
                button8Record.maximum = button8MaximumRecord
                recordInfo.button4 = button4Record
                recordInfo.button5 = button5Record
                recordInfo.button6 = button6Record
                recordInfo.button8 = button8Record
                NewRecordInfo.add(recordInfo)
            }
        }
        Skill.refresh()
        finishesSong = true
        plusDataCount()
    }
    
    @objc func didReceiveMissions(_ notification: Notification) {
        guard let userInfo = notification.userInfo?["missions"] as? MissionResponse else { return }
        let downloadedMissions = userInfo.missions
        let results = MissionInfo.fetch()
        for downloadedMission in downloadedMissions {
            let predicate = NSPredicate(format: "%K == %@", #keyPath(MissionInfo.title), downloadedMission.title)
            if let result = results.filter(predicate).first {
                MissionInfo.update(downloadedMission, to: result)
            } else {
                MissionInfo.add(downloadedMission)
            }
        }
        finishesMission = true
        plusDataCount()
    }
    
    @objc func didReceiveTrophies(_ notification: Notification) {
        guard let userInfo = notification.userInfo?["trophies"] as? TrophyResponse else { return }
        let downloadedTrophies = userInfo.trophies
        let results = TrophyInfo.fetch()
        for downloadedTrophy in downloadedTrophies {
            let predicate = NSPredicate(format: "%K == %@", #keyPath(TrophyInfo.image), downloadedTrophy.image)
            if let result = results.filter(predicate).first {
                TrophyInfo.update(downloadedTrophy, to: result)
            } else {
                TrophyInfo.add(downloadedTrophy)
            }
        }
        finishesTrophy = true
        plusDataCount()
    }
    
    @objc func didReceiveAchievements(_ notification: Notification) {
        guard let userInfo = notification.userInfo?["achievements"] as? AchievementResponse else { return }
        let downloadedAchievements = userInfo.achievements
        let results = AchievementInfo.fetch()
        for downloadedAchievement in downloadedAchievements {
            let predicate = NSPredicate(format: "%K == %@ AND %K == %@", #keyPath(AchievementInfo.item.english), downloadedAchievement.item.english, #keyPath(AchievementInfo.type), downloadedAchievement.type)
            if let result = results.filter(predicate).first {
                AchievementInfo.update(downloadedAchievement, to: result)
            } else {
                AchievementInfo.add(downloadedAchievement)
            }
        }
        finishesAchievement = true
        plusDataCount()
    }
    
    @objc func didReceiveTips(_ notification: Notification) {
        guard let userInfo = notification.userInfo?["tips"] as? TipResponse else { return }
        let downloadedTips = userInfo.tips
        let results = TipInfo.fetch()
        for downloadedTip in downloadedTips {
            let predicate = NSPredicate(format: "%K == %@", #keyPath(TipInfo.title.english), downloadedTip.title.english)
            if let result = results.filter(predicate).first {
                TipInfo.update(downloadedTip, to: result)
            } else {
                TipInfo.add(downloadedTip)
            }
        }
        finishesTip = true
        plusDataCount()
    }
    
    @objc func didReceiveVersions(_ notification: Notification) {
        guard let userInfo = notification.userInfo?["versions"] as? VersionResponse else { return }
        if let result = VersionInfo.fetch().first {
            VersionInfo.update(userInfo, to: result)
        } else {
            VersionInfo.add(userInfo)
        }
        finishesVersion = true
        plusDataCount()
    }
    
    @objc func didReceiveRecords(_ notification: Notification) {
        //guard let userInfo = notification.userInfo?["records"] as? RecordResponse else { return }
        //성과기록 데이터베이스 갱신.
        finishesRecord = true
        plusRecordCount()
    }
    
    @objc func errorReceiveSongs(_ notification: Notification) {
        plusDataCount()
    }
    
    @objc func errorReceiveMissions(_ notification: Notification) {
        plusDataCount()
    }
    
    @objc func errorReceiveTrophies(_ notification: Notification) {
        plusDataCount()
    }
    
    @objc func errorReceiveAchievements(_ notification: Notification) {
        plusDataCount()
    }
    
    @objc func errorReceiveTips(_ notification: Notification) {
        plusDataCount()
    }
    
    @objc func errorReceiveVersions(_ notification: Notification) {
        plusDataCount()
    }
    
    @objc func errorReceiveRecords(_ notification: Notification) {
        plusRecordCount()
    }
}

extension DownloadViewController {
    private func presentSuccessAlert() {
        UIAlertController
            .alert(title: "", message: "Your data has been successfully downloaded.".localized)
            .action(title: "OK".localized) { [weak self] _ in
                self?.parent?.dismiss(animated: true, completion: nil)
            }
            .present(to: self)
    }
    
    private func presentFailureAlert() {
        UIAlertController
            .alert(title: "", message: "Network Error".localized)
            .action(title: "OK".localized) { [weak self] _ in
                self?.dataCount = 0
            }
            .present(to: self)
    }
    
    private func plusDataCount() {
        DispatchQueue.main.sync { [weak self] in
            self?.dataCount += 1
        }
    }
    
    private func plusRecordCount() {
        DispatchQueue.main.sync { [weak self] in
            self?.recordCount += 1
        }
    }
}


