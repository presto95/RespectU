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
    var isValidVersion: Bool = false {
        didSet {
            if isValidVersion {
                showIndicator()
                API.requestSongs(completion: didReceiveSongs)
                API.requestMissions(completion: didReceiveMissions)
                API.requestTrophies(completion: didReceiveTrophies)
                API.requestAchievements(completion: didReceiveAchievements)
                API.requestTips(completion: didReceiveTips)
            }
        }
    }
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
        setup()
    }
    
    func setup() {
        downloadDataButton.layer.cornerRadius = 10
        downloadDataButton.backgroundColor = .main
        downloadRecordButton.layer.cornerRadius = 10
        downloadRecordButton.backgroundColor = .main
        downloadDataLabel.text = "Update with latest data.".localized
        downloadRecordLabel.text = "Get exported performance record data.".localized
        downloadDataButton.setTitle("Download".localized, for: [])
        downloadRecordButton.setTitle("Download".localized, for: [])
        downloadDataButton.addTarget(self, action: #selector(didTouchUpDownloadDataButton(_:)), for: .touchUpInside)
        downloadRecordButton.addTarget(self, action: #selector(didTouchUpDownloadRecordButton(_:)), for: .touchUpInside)
    }
    
    @objc func didTouchUpDownloadDataButton(_ sender: UIButton) {
        API.requestVersions(completion: didReceiveVersions)
    }
    
    @objc func didTouchUpDownloadRecordButton(_ sender: UIButton) {
        let id = KeychainWrapper.standard.string(forKey: "id") ?? ""
        if id.isEmpty {
            UIAlertController
                .alert(title: "", message: "First Log In.".localized)
                .action(title: "OK".localized)
                .present(to: self)
        } else {
            UIAlertController
                .alert(title: "Warning".localized, message: "If there is no data on the server, the recorded performance information can be initialized.".localized)
                .action(.destructive, title: "OK".localized, handler: { [weak self] _ in
                    guard let `self` = self else { return }
                    DispatchQueue.main.async {
                        self.showIndicator()
                    }
                    API.requestRecords(id, completion: self.didReceiveRecords)
                })
                .action(.cancel, title: "Cancel".localized)
                .present(to: self)
        }
    }
    
    @IBAction func didTouchUpCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

private extension DownloadViewController {
    func didReceiveSongs(response: SongResponse?, error: Error?) {
        if let error = error {
            plusDataCount()
            UIAlertController.presentErrorAlert(to: self, error: error.localizedDescription)
            return
        }
        guard let response = response else { return }
        let downloadedSongs = response.songs
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
    
    func didReceiveMissions(response: MissionResponse?, error: Error?) {
        if let error = error {
            plusDataCount()
            UIAlertController.presentErrorAlert(to: self, error: error.localizedDescription)
            return
        }
        guard let response = response else { return }
        let downloadedMissions = response.missions
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

    func didReceiveTrophies(response: TrophyResponse?, error: Error?) {
        if let error = error {
            plusDataCount()
            UIAlertController.presentErrorAlert(to: self, error: error.localizedDescription)
            return
        }
        guard let response = response else { return }
        let downloadedTrophies = response.trophies
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
    
    func didReceiveAchievements(response: AchievementResponse?, error: Error?) {
        if let error = error {
            plusDataCount()
            UIAlertController.presentErrorAlert(to: self, error: error.localizedDescription)
            return
        }
        guard let response = response else { return }
        let downloadedAchievements = response.achievements
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
    
    func didReceiveTips(response: TipResponse?, error: Error?) {
        if let error = error {
            plusDataCount()
            UIAlertController.presentErrorAlert(to: self, error: error.localizedDescription)
            return
        }
        guard let response = response else { return }
        let downloadedTips = response.tips
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
    
    func didReceiveVersions(response: VersionResponse?, error: Error?) {
        if let error = error {
            plusDataCount()
            UIAlertController.presentErrorAlert(to: self, error: error.localizedDescription)
            return
        }
        guard let response = response else { return }
        if let result = VersionInfo.fetch().first {
            VersionInfo.update(response, to: result)
        } else {
            VersionInfo.add(response)
        }
        finishesVersion = true
        plusDataCount()
    }
    
    func didReceiveRecords(response: RecordResponse?, error: Error?) {
        if let error = error {
            plusRecordCount()
            UIAlertController.presentErrorAlert(to: self, error: error.localizedDescription)
            return
        }
        guard let response = response else { return }
        let results = NewRecordInfo.fetch()
        let records = response.records
        for record in records {
            let predicate = NSPredicate(format: "%K == %@", #keyPath(NewRecordInfo.title.english), record.title.english)
            guard let result = results.filter(predicate).first else { continue }
            NewRecordInfo.update(record, to: result)
        }
        finishesRecord = true
        plusRecordCount()
    }
    
    func didReceiveVersion(response: VersionResponse?, error: Error?) {
        if let error = error {
            UIAlertController.presentErrorAlert(to: self, error: error.localizedDescription)
            return
        }
        guard let response = response else { return }
        if response.clientVersion != version {
            DispatchQueue.main.async {
                UIAlertController
                    .alert(title: "", message: "New version released!\nPlease use it after updating.".localized)
                    .action(title: "Update".localized, handler: { _ in
                        guard let url = URL(string: "itms-apps://itunes.apple.com/app/id1291664067") else { return }
                        guard #available(iOS 10, *) else {
                            UIApplication.shared.openURL(url)
                            return
                        }
                        UIApplication.shared.open(url, options: [:])
                    })
                    .action(.cancel, title: "Cancel".localized)
                    .present(to: self)
            }
        } else {
            isValidVersion = true
        }
    }
}

private extension DownloadViewController {
    func presentSuccessAlert() {
        UIAlertController
            .alert(title: "", message: "Your data has been successfully downloaded.".localized)
            .action(title: "OK".localized) { [weak self] _ in
                self?.parent?.dismiss(animated: true, completion: nil)
            }
            .present(to: self)
    }
    
    func presentFailureAlert() {
        UIAlertController
            .alert(title: "", message: "Network Error".localized)
            .action(title: "OK".localized) { [weak self] _ in
                self?.dataCount = 0
            }
            .present(to: self)
    }
    
    func plusDataCount() {
        DispatchQueue.main.sync { [weak self] in
            self?.dataCount += 1
        }
    }
    
    func plusRecordCount() {
        DispatchQueue.main.sync { [weak self] in
            self?.recordCount += 1
        }
    }
}
