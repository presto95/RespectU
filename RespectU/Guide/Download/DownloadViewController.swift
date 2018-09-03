//
//  DownloadViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 29..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

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
        self.downloadDataButton.layer.cornerRadius = 10
        self.downloadDataButton.backgroundColor = .main
        self.downloadRecordButton.layer.cornerRadius = 10
        self.downloadRecordButton.backgroundColor = .main
        self.downloadDataLabel.text = "Renew with latest data.".localized
        self.downloadRecordLabel.text = "Get exported performance record data.".localized
        self.downloadDataButton.setTitle("Download".localized, for: [])
        self.downloadRecordButton.setTitle("Download", for: [])
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
    }
    
    @objc func touchUpDownloadDataButton(_ sender: UIButton) {
        API.requestSongs()
        API.requestMissions()
        API.requestTrophies()
        API.requestAchievements()
        API.requestTips()
        API.requestVersions()
    }
    
    @objc func touchUpDownloadRecordButton(_ sender: UIButton) {
        
    }
    
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension DownloadViewController {
    @objc func didReceiveSongs(_ notification: Notification) {
        guard let userInfo = notification.userInfo?["songs"] as? SongResponse else { return }
        for song in userInfo.songs {
            SongInfo.add(song)
        }
    }
    
    @objc func didReceiveMissions(_ notification: Notification) {
        guard let userInfo = notification.userInfo?["missions"] as? MissionResponse else { return }
        for mission in userInfo.missions {
            MissionInfo.add(mission)
        }
    }
    
    @objc func didReceiveTrophies(_ notification: Notification) {
        guard let userInfo = notification.userInfo?["trophies"] as? TrophyResponse else { return }
        for trophy in userInfo.trophies {
            TrophyInfo.add(trophy)
        }
    }
    
    @objc func didReceiveAchievements(_ notification: Notification) {
        guard let userInfo = notification.userInfo?["achievements"] as? AchievementResponse else { return }
        for achievement in userInfo.achievements {
            AchievementInfo.add(achievement)
        }
    }
    
    @objc func didReceiveTips(_ notification: Notification) {
        guard let userInfo = notification.userInfo?["tips"] as? TipResponse else { return }
        for tip in userInfo.tips {
            TipInfo.add(tip)
        }
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

extension DownloadViewController {
    private func presentSuccessAlert() {
        UIAlertController
            .alert(title: "", message: "Your data has been successfully downloaded.".localized)
            .defaultAction(title: "OK".localized) { [weak self] _ in
                self?.parent?.dismiss(animated: true, completion: nil)
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


