//
//  StartViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 9. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

class InitViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    var finishesSong: Bool = false
    var finishesMission: Bool = false
    var finishesTrophy: Bool = false
    var finishesAchievement: Bool = false
    var finishesTip: Bool = false
    var finishesVersion: Bool = false
    var count = 0 {
        didSet {
            if count == 6 {
                hideIndicator()
                if finishesAll {
                    presentSuccessAlert()
                } else {
                    presentFailureAlert()
                }
            }
        }
    }
    var finishesAll: Bool {
        if finishesSong, finishesMission, finishesTrophy, finishesAchievement, finishesTip, finishesVersion {
            return true
        }
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.descriptionLabel.text = "Download data to start the application.".localized
        self.startButton.setTitle("Download".localized, for: [])
        self.startButton.addTarget(self, action: #selector(touchUpDownloadButton(_:)), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveSongs(_:)), name: .didReceiveSongs, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveMissions(_:)), name: .didReceiveMissions, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveTrophies(_:)), name: .didReceiveTrophies, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveAchievements(_:)), name: .didReceiveAchievements, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveTips(_:)), name: .didReceiveTips, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(errorReceiveSongs(_:)), name: .errorReceiveSongs, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(errorReceiveMissions(_:)), name: .errorReceiveMissions, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(errorReceiveTrophies(_:)), name: .errorReceiveTrophies, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(errorReceiveAchievements(_:)), name: .errorReceiveAchievements, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(errorReceiveTips(_:)), name: .errorReceiveTips, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveVersions(_:)), name: .didReceiveVersions, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(errorReceiveVersions(_:)), name: .errorReceiveVersions, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    @objc func touchUpDownloadButton(_ sender: UIButton) {
        showIndicator()
        API.requestSongs()
        API.requestMissions()
        API.requestTrophies()
        API.requestAchievements()
        API.requestTips()
        API.requestVersions()
    }
}

extension InitViewController {
    @objc func didReceiveSongs(_ notification: Notification) {
        guard let userInfo = notification.userInfo?["songs"] as? SongResponse else { return }
        for song in userInfo.songs {
            SongInfo.add(song)
        }
        finishesSong = true
        plusCount()
    }
    
    @objc func didReceiveMissions(_ notification: Notification) {
        guard let userInfo = notification.userInfo?["missions"] as? MissionResponse else { return }
        for mission in userInfo.missions {
            MissionInfo.add(mission)
        }
        finishesMission = true
        plusCount()
    }
    
    @objc func didReceiveTrophies(_ notification: Notification) {
        guard let userInfo = notification.userInfo?["trophies"] as? TrophyResponse else { return }
        for trophy in userInfo.trophies {
            TrophyInfo.add(trophy)

        }
        finishesTrophy = true
        plusCount()
    }
    
    @objc func didReceiveAchievements(_ notification: Notification) {
        guard let userInfo = notification.userInfo?["achievements"] as? AchievementResponse else { return }
        for achievement in userInfo.achievements {
            AchievementInfo.add(achievement)
        }
        finishesAchievement = true
        plusCount()
    }
    
    @objc func didReceiveTips(_ notification: Notification) {
        guard let userInfo = notification.userInfo?["tips"] as? TipResponse else { return }
        for tip in userInfo.tips {
            TipInfo.add(tip)
        }
        finishesTip = true
        plusCount()
    }
    
    @objc func didReceiveVersions(_ notification: Notification) {
        guard let userInfo = notification.userInfo?["versions"] as? VersionResponse else { return }
        VersionInfo.add(userInfo)
        finishesVersion = true
        plusCount()
    }
    
    @objc func errorReceiveSongs(_ notification: Notification) {
        plusCount()
    }
    
    @objc func errorReceiveMissions(_ notification: Notification) {
        plusCount()
    }
    
    @objc func errorReceiveTrophies(_ notification: Notification) {
        plusCount()
    }
    
    @objc func errorReceiveAchievements(_ notification: Notification) {
        plusCount()
    }
    
    @objc func errorReceiveTips(_ notification: Notification) {
        plusCount()
    }
    
    @objc func errorReceiveVersions(_ notification: Notification) {
        plusCount()
    }
}

extension InitViewController {
    private func presentSuccessAlert() {
        let results = SongInfo.fetch()
        let oldResults = RecordInfo.get()
        UIAlertController
            .alert(title: "", message: "Your data has been successfully downloaded.".localized)
            .action(title: "OK".localized) { _ in
                for result in results {
                    let recordInfo = NewRecordInfo()
                    recordInfo.title = result.title
                    recordInfo.series = result.series
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
                    if let oldRecord = oldResults.filter("title = %@ OR title = %@", result.title?.english ?? "", result.title?.korean ?? "").first {
                        button4NormalRecord.rank = oldRecord.nm4Rank == "-" ? "" : oldRecord.nm4Rank
                        button4NormalRecord.rate = oldRecord.nm4Rate.rateConvertToDouble
                        button4NormalRecord.note = oldRecord.nm4Note == "-" ? "" : oldRecord.nm4Note
                        button4Record.normal = button4NormalRecord
                        button4HardRecord.rank = oldRecord.hd4Rank == "-" ? "" : oldRecord.hd4Rank
                        button4HardRecord.rate = oldRecord.hd4Rate.rateConvertToDouble
                        button4HardRecord.note = oldRecord.hd4Note == "-" ? "" : oldRecord.hd4Note
                        button4Record.hard = button4HardRecord
                        button4MaximumRecord.rank = oldRecord.mx4Rank == "-" ? "" : oldRecord.mx4Rank
                        button4MaximumRecord.rate = oldRecord.mx4Rate.rateConvertToDouble
                        button4MaximumRecord.note = oldRecord.mx4Note == "-" ? "" : oldRecord.mx4Note
                        button4Record.maximum = button4MaximumRecord
                        recordInfo.button4 = button4Record
                        button5NormalRecord.rank = oldRecord.nm5Rank == "-" ? "" : oldRecord.nm5Rank
                        button5NormalRecord.rate = oldRecord.nm5Rate.rateConvertToDouble
                        button5NormalRecord.note = oldRecord.nm5Note == "-" ? "" : oldRecord.nm5Note
                        button5Record.normal = button5NormalRecord
                        button5HardRecord.rank = oldRecord.hd5Rank == "-" ? "" : oldRecord.hd5Rank
                        button5HardRecord.rate = oldRecord.hd5Rate.rateConvertToDouble
                        button5HardRecord.note = oldRecord.hd5Note == "-" ? "" : oldRecord.hd5Note
                        button5Record.hard = button5HardRecord
                        button5MaximumRecord.rank = oldRecord.mx5Rank == "-" ? "" : oldRecord.mx5Rank
                        button5MaximumRecord.rate = oldRecord.mx5Rate.rateConvertToDouble
                        button5MaximumRecord.note = oldRecord.mx5Note == "-" ? "" : oldRecord.mx5Note
                        button5Record.maximum = button5MaximumRecord
                        recordInfo.button5 = button5Record
                        button6NormalRecord.rank = oldRecord.nm6Rank == "-" ? "" : oldRecord.nm6Rank
                        button6NormalRecord.rate = oldRecord.nm6Rate.rateConvertToDouble
                        button6NormalRecord.note = oldRecord.nm6Note == "-" ? "" : oldRecord.nm6Note
                        button6Record.normal = button6NormalRecord
                        button6HardRecord.rank = oldRecord.hd6Rank == "-" ? "" : oldRecord.hd6Rank
                        button6HardRecord.rate = oldRecord.hd6Rate.rateConvertToDouble
                        button6HardRecord.note = oldRecord.hd6Note == "-" ? "" : oldRecord.hd6Note
                        button6Record.hard = button6HardRecord
                        button6MaximumRecord.rank = oldRecord.mx6Rank == "-" ? "" : oldRecord.mx6Rank
                        button6MaximumRecord.rate = oldRecord.mx6Rate.rateConvertToDouble
                        button6MaximumRecord.note = oldRecord.mx6Note == "-" ? "" : oldRecord.mx6Note
                        button6Record.maximum = button6MaximumRecord
                        recordInfo.button6 = button6Record
                        button8NormalRecord.rank = oldRecord.nm8Rank == "-" ? "" : oldRecord.nm8Rank
                        button8NormalRecord.rate = oldRecord.nm8Rate.rateConvertToDouble
                        button8NormalRecord.note = oldRecord.nm8Note == "-" ? "" : oldRecord.nm8Note
                        button8Record.normal = button8NormalRecord
                        button8HardRecord.rank = oldRecord.hd8Rank == "-" ? "" : oldRecord.hd8Rank
                        button8HardRecord.rate = oldRecord.hd8Rate.rateConvertToDouble
                        button8HardRecord.note = oldRecord.hd8Note == "-" ? "" : oldRecord.hd8Note
                        button8Record.hard = button8HardRecord
                        button8MaximumRecord.rank = oldRecord.mx8Rank == "-" ? "" : oldRecord.mx8Rank
                        button8MaximumRecord.rate = oldRecord.mx8Rate.rateConvertToDouble
                        button8MaximumRecord.note = oldRecord.mx8Note == "-" ? "" : oldRecord.mx8Note
                        button8Record.maximum = button8MaximumRecord
                        recordInfo.button8 = button8Record
                    } else {
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
                    }
                    NewRecordInfo.add(recordInfo)
                }
                guard let next = UIViewController.instantiate(storyboard: "Performance", identifier: "PerformanceNavigationController") else { return }
                next.modalTransitionStyle = .crossDissolve
                self.present(next, animated: true, completion: nil)
            }
            .present(to: self)
    }
    
    private func presentFailureAlert() {
        UIAlertController
            .alert(title: "", message: "Network Error".localized)
            .action(title: "OK".localized) { [weak self] _ in
                self?.count = 0
            }
            .present(to: self)
    }
    
    private func plusCount() {
        DispatchQueue.main.sync { [weak self] in
            self?.count += 1
        }
    }
}
