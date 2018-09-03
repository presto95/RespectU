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
            let imageURL = "\(API.baseUrl)/images/\(trophy.series)/\(trophy.image).png"
            guard let url = URL(string: imageURL) else { return }
            guard let imageData = try? Data(contentsOf: url) else { return }
            guard let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
            let fileURL = documentURL.appendingPathComponent("\(trophy.image).png")
            do {
                try imageData.write(to: fileURL, options: .atomic)
            } catch {
                print(error.localizedDescription)
            }
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
    
    private func presentFailureAlert() {
        UIAlertController
            .alert(title: "", message: "Network Error".localized)
            .defaultAction(title: "OK".localized) { [weak self] _ in
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
