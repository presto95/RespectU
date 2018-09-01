//
//  StartViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 9. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

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
    
    @objc func didReceiveSongs(_ notification: Notification) {
        guard let userInfo = notification.userInfo?["songs"] as? SongResponse else { return }
        print("song start")
        for song in userInfo.songs {
            SongInfo.add(song)
        }
        print("song finished")
    }
    
    @objc func didReceiveMissions(_ notification: Notification) {
        guard let userInfo = notification.userInfo?["missions"] as? MissionResponse else { return }
        print("mission start")
        for mission in userInfo.missions {
            MissionInfo.add(mission)
        }
        print("mission finished")
    }
    
    @objc func didReceiveTrophies(_ notification: Notification) {
        guard let userInfo = notification.userInfo?["trophies"] as? TrophyResponse else { return }
        print("trophy start")
        for trophy in userInfo.trophies {
            TrophyInfo.add(trophy)
        }
        print("trophy finished")
    }
    
    @objc func didReceiveAchievements(_ notification: Notification) {
        guard let userInfo = notification.userInfo?["achievements"] as? AchievementResponse else { return }
        print("achievement start")
        for achievement in userInfo.achievements {
            AchievementInfo.add(achievement)
        }
        print("achievement finished")
    }
    
    @objc func didReceiveTips(_ notification: Notification) {
        guard let userInfo = notification.userInfo?["tips"] as? TipResponse else { return }
        print("tip start")
        for tip in userInfo.tips {
            TipInfo.add(tip)
        }
        print("tip finished")
    }
    
    @objc func errorReceiveSongs(_ notification: Notification) {
        guard let error = notification.userInfo?["error"] as? String else { return }
        print("song", error)
        //presentFailureAlert(error)
    }
    
    @objc func errorReceiveMissions(_ notification: Notification) {
        guard let error = notification.userInfo?["error"] as? String else { return }
        print("mission", error)
        //presentFailureAlert(error)
    }
    
    @objc func errorReceiveTrophies(_ notification: Notification) {
        guard let error = notification.userInfo?["error"] as? String else { return }
        print("trophy", error)
        //presentFailureAlert(error)
    }
    
    @objc func errorReceiveAchievements(_ notification: Notification) {
        guard let error = notification.userInfo?["error"] as? String else { return }
        print("achievement", error)
        //presentFailureAlert(error)
    }
    
    @objc func errorReceiveTips(_ notification: Notification) {
        guard let error = notification.userInfo?["error"] as? String else { return }
        print("tip", error)
        //presentFailureAlert(error)
    }
    
    func presentCompletionAlert() {
        print("success")
//        UIAlertController
//            .alert(title: "", message: "Your data has been successfully downloaded.".localized)
//            .defaultAction(title: "OK".localized) { [weak self] _ in
//                self?.hideIndicator()
//                self?.parent?.dismiss(animated: true, completion: nil)
//            }
//            .present(to: self)
    }
    
    func presentFailureAlert(_ error: String) {
        print("fail")
//        UIAlertController
//            .alert(title: "", message: error)
//            .defaultAction(title: "OK".localized) { [weak self] _ in
//                self?.hideIndicator()
//            }
//            .present(to: self)
    }

    @IBAction func touchUpDownloadButton(_ sender: UIButton) {
        API.requestSongs()
        API.requestMissions()
        API.requestTrophies()
        API.requestAchievements()
        API.requestTips()
    }
}
