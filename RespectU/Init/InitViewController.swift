//
//  StartViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 9. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

class InitViewController: UIViewController {

    var finishesSong: Bool = false
    var finishesMission: Bool = false
    var finishesTrophy: Bool = false
    var finishesAchievement: Bool = false
    var finishesTip: Bool = false
    var count = 0 {
        didSet {
            if count == 5 {
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
        if finishesSong, finishesMission, finishesTrophy, finishesAchievement, finishesTip {
            return true
        }
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func didReceiveSongs(_ notification: Notification) {
        guard let userInfo = notification.userInfo?["songs"] as? SongResponse else { return }
        for song in userInfo.songs {
            SongInfo.add(song)
        }
        finishesSong = true
        DispatchQueue.main.sync {
            count += 1
        }
    }
    
    @objc func didReceiveMissions(_ notification: Notification) {
        guard let userInfo = notification.userInfo?["missions"] as? MissionResponse else { return }
        for mission in userInfo.missions {
            MissionInfo.add(mission)
        }
        finishesMission = true
        DispatchQueue.main.sync {
            count += 1
        }
    }
    
    @objc func didReceiveTrophies(_ notification: Notification) {
        guard let userInfo = notification.userInfo?["trophies"] as? TrophyResponse else { return }
        for trophy in userInfo.trophies {
            TrophyInfo.add(trophy)
        }
        finishesTrophy = true
        DispatchQueue.main.sync {
            count += 1
        }
    }
    
    @objc func didReceiveAchievements(_ notification: Notification) {
        guard let userInfo = notification.userInfo?["achievements"] as? AchievementResponse else { return }
        for achievement in userInfo.achievements {
            AchievementInfo.add(achievement)
        }
        finishesAchievement = true
        DispatchQueue.main.sync {
            count += 1
        }
    }
    
    @objc func didReceiveTips(_ notification: Notification) {
        guard let userInfo = notification.userInfo?["tips"] as? TipResponse else { return }
        for tip in userInfo.tips {
            TipInfo.add(tip)
        }
        finishesTip = true
        DispatchQueue.main.sync {
            count += 1
        }
    }
    
    @objc func errorReceiveSongs(_ notification: Notification) {
        DispatchQueue.main.sync {
            count += 1
        }
    }
    
    @objc func errorReceiveMissions(_ notification: Notification) {
        DispatchQueue.main.sync {
            count += 1
        }
    }
    
    @objc func errorReceiveTrophies(_ notification: Notification) {
        DispatchQueue.main.sync {
            count += 1
        }
    }
    
    @objc func errorReceiveAchievements(_ notification: Notification) {
        DispatchQueue.main.sync {
            count += 1
        }
    }
    
    @objc func errorReceiveTips(_ notification: Notification) {
        DispatchQueue.main.sync {
            count += 1
        }
    }
    
    func presentSuccessAlert() {
        let results = SongInfo.fetch()
        UIAlertController
            .alert(title: "", message: "Your data has been successfully downloaded.".localized)
            .defaultAction(title: "OK".localized) { _ in
                for result in results {
                    let recordInfo = RecordInfo()
                    recordInfo.title = result.title
                    recordInfo.series = result.series
                    let recordButton = RecordButtonInfo()
                    let difficultyRecord = RecordPerformanceInfo()
                    recordButton.normal = difficultyRecord
                    recordButton.hard = difficultyRecord
                    recordButton.maximum = difficultyRecord
                    recordInfo.button4 = recordButton
                    recordInfo.button5 = recordButton
                    recordInfo.button6 = recordButton
                    recordInfo.button8 = recordButton
                    RecordInfo.add(recordInfo)
                }
                guard let next = UIViewController.instantiate(storyboard: "Performance", identifier: "PerformanceNavigationController") else { return }
                next.modalTransitionStyle = .crossDissolve
                self.present(next, animated: true, completion: nil)
            }
            .present(to: self)
    }
    
    func presentFailureAlert() {
        UIAlertController
            .alert(title: "", message: "Network Error".localized)
            .defaultAction(title: "OK".localized) { [weak self] _ in
                self?.count = 0
            }
            .present(to: self)
    }
    

    @IBAction func touchUpDownloadButton(_ sender: UIButton) {
        showIndicator()
        API.requestSongs()
        API.requestMissions()
        API.requestTrophies()
        API.requestAchievements()
        API.requestTips()
    }
}
