//
//  DownloadViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 29..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

class DownloadViewController: UIViewController {

    @IBOutlet weak var downloadDataButton: UIButton!
    @IBOutlet weak var downloadRecordButton: UIButton!
    var count: Int = 0 {
        willSet {
            if newValue == 5 {
                presentCompletionAlert()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.downloadDataButton.layer.cornerRadius = 10
        self.downloadDataButton.backgroundColor = .main
        self.downloadRecordButton.layer.cornerRadius = 10
        self.downloadRecordButton.backgroundColor = .main
        self.downloadDataButton.addTarget(self, action: #selector(touchUpDownloadDataButton(_:)), for: .touchUpInside)
        self.downloadRecordButton.addTarget(self, action: #selector(touchUpDownloadRecordButton(_:)), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveSongs(_:)), name: .didReceiveSongs, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveMissions(_:)), name: .didReceiveMissions, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveTrophies(_:)), name: .didReceiveTrophies, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveAchievements(_:)), name: .didReceiveAchievements, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveTips(_:)), name: .didReceiveTips, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(errorReceiveDownloadData(_:)), name: .errorReceiveSongs, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(errorReceiveDownloadData(_:)), name: .errorReceiveMissions, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(errorReceiveDownloadData(_:)), name: .errorReceiveTrophies, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(errorReceiveDownloadData(_:)), name: .errorReceiveAchievements, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(errorReceiveDownloadData(_:)), name: .errorReceiveTips, object: nil)
    }
    
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
    
    @objc func errorReceiveDownloadData(_ notification: Notification) {
        guard let error = notification.userInfo?["error"] as? String else { return }
        presentFailureAlert(error)
    }
    
    func presentCompletionAlert() {
        UIAlertController
            .alert(title: "", message: "Your data has been successfully downloaded.".localized)
            .defaultAction(title: "OK".localized) { [weak self] _ in
                self?.hideIndicator()
                self?.parent?.dismiss(animated: true, completion: nil)
            }
            .present(to: self)
    }
    
    func presentFailureAlert(_ error: String) {
        UIAlertController
            .alert(title: "", message: error)
            .defaultAction(title: "OK".localized) { [weak self] _ in
                self?.hideIndicator()
            }
            .present(to: self)
    }
}

extension DownloadViewController {
    @objc func touchUpDownloadDataButton(_ sender: UIButton) {
        API.requestSongs()
        API.requestMissions()
        API.requestTrophies()
        API.requestAchievements()
        API.requestTips()
    }
    
    @objc func touchUpDownloadRecordButton(_ sender: UIButton) {
        
    }
    
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
