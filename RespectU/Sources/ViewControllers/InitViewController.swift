//
//  StartViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 9. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import SVProgressHUD

final class InitViewController: UIViewController {
  
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
        SVProgressHUD.dismiss()
        
        if finishesAll {
          presentSuccessAlert()
        } else {
          UIAlertController.presentErrorAlert(to: self, error: "Network Error".localized)
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
    setup()
  }
  
  func setup() {
    descriptionLabel.text = "Download data to start the application.".localized
    startButton.setTitle("Download".localized, for: [])
    startButton.addTarget(self, action: #selector(didTouchUpDownloadButton(_:)), for: .touchUpInside)
  }
  
  @objc func didTouchUpDownloadButton(_ sender: UIButton) {
    SVProgressHUD.show()
    APIService.requestSongs(completion: didReceiveSongs)
    APIService.requestMissions(completion: didReceiveMissions)
    APIService.requestTrophies(completion: didReceiveTrophies)
    APIService.requestAchievements(completion: didReceiveAchievements)
    APIService.requestTips(completion: didReceiveTips)
    APIService.requestVersions(completion: didReceiveVersions)
  }
}

private extension InitViewController {
  
  func didReceiveSongs(response: SongResponse?, error: Error?) {
    if let error = error {
      plusCount()
      UIAlertController.presentErrorAlert(to: self, error: error.localizedDescription)
      return
    }
    guard let response = response else { return }
    for song in response.songs {
      SongInfo.add(song)
    }
    finishesSong = true
    plusCount()
  }
  
  func didReceiveMissions(response: MissionResponse?, error: Error?) {
    if let error = error {
      plusCount()
      UIAlertController.presentErrorAlert(to: self, error: error.localizedDescription)
      return
    }
    guard let response = response else { return }
    for mission in response.missions {
      MissionInfo.add(mission)
    }
    finishesMission = true
    plusCount()
  }
  
  func didReceiveTrophies(response: TrophyResponse?, error: Error?) {
    if let error = error {
      plusCount()
      UIAlertController.presentErrorAlert(to: self, error: error.localizedDescription)
      return
    }
    guard let response = response else { return }
    for trophy in response.trophies {
      TrophyInfo.add(trophy)
    }
    finishesTrophy = true
    plusCount()
  }
  
  func didReceiveAchievements(response: AchievementResponse?, error: Error?) {
    if let error = error {
      plusCount()
      UIAlertController.presentErrorAlert(to: self, error: error.localizedDescription)
      return
    }
    guard let response = response else { return }
    for achievement in response.achievements {
      AchievementInfo.add(achievement)
    }
    finishesAchievement = true
    plusCount()
  }
  
  func didReceiveTips(response: TipResponse?, error: Error?) {
    if let error = error {
      plusCount()
      UIAlertController.presentErrorAlert(to: self, error: error.localizedDescription)
      return
    }
    guard let response = response else { return }
    for tip in response.tips {
      TipInfo.add(tip)
    }
    finishesTip = true
    plusCount()
  }
  
  func didReceiveVersions(response: VersionResponse?, error: Error?) {
    if let error = error {
      plusCount()
      UIAlertController.presentErrorAlert(to: self, error: error.localizedDescription)
      return
    }
    guard let response = response else { return }
    VersionInfo.add(response)
    finishesVersion = true
    plusCount()
  }
}

extension InitViewController {
  
  private func presentSuccessAlert() {
    let results = SongInfo.fetch()
    let oldResults = OldRecordInfo.get()
    UIAlertController
      .alert(title: "", message: "Your data has been successfully downloaded.".localized)
      .action(title: "OK".localized) { _ in
        SVProgressHUD.show()
        for result in results {
          let recordInfo = RecordInfo()
          recordInfo.title = result.title
          recordInfo.series = result.series
          let button4Record = RecordButtonInfo()
          let button5Record = RecordButtonInfo()
          let button6Record = RecordButtonInfo()
          let button8Record = RecordButtonInfo()
          let button4NormalRecord = RecordDifficultyInfo()
          let button4HardRecord = RecordDifficultyInfo()
          let button4MaximumRecord = RecordDifficultyInfo()
          let button5NormalRecord = RecordDifficultyInfo()
          let button5HardRecord = RecordDifficultyInfo()
          let button5MaximumRecord = RecordDifficultyInfo()
          let button6NormalRecord = RecordDifficultyInfo()
          let button6HardRecord = RecordDifficultyInfo()
          let button6MaximumRecord = RecordDifficultyInfo()
          let button8NormalRecord = RecordDifficultyInfo()
          let button8HardRecord = RecordDifficultyInfo()
          let button8MaximumRecord = RecordDifficultyInfo()
          if let oldRecord = oldResults.filter("title = %@ OR title = %@", result.title?.english ?? "", result.title?.korean ?? "").first {
            button4NormalRecord.rank = oldRecord.nm4Rank == "-" ? "" : oldRecord.nm4Rank
            button4NormalRecord.rate = oldRecord.nm4Rate.rateConvertToDouble
            button4NormalRecord.note = oldRecord.nm4Note.noteAbbreviation
            button4Record.normal = button4NormalRecord
            button4HardRecord.rank = oldRecord.hd4Rank == "-" ? "" : oldRecord.hd4Rank
            button4HardRecord.rate = oldRecord.hd4Rate.rateConvertToDouble
            button4HardRecord.note = oldRecord.hd4Note.noteAbbreviation
            button4Record.hard = button4HardRecord
            button4MaximumRecord.rank = oldRecord.mx4Rank == "-" ? "" : oldRecord.mx4Rank
            button4MaximumRecord.rate = oldRecord.mx4Rate.rateConvertToDouble
            button4MaximumRecord.note = oldRecord.mx4Note.noteAbbreviation
            button4Record.maximum = button4MaximumRecord
            button4Record.skillPoint = oldRecord.button4SkillPoint
            button4Record.skillPointDifficulty = oldRecord.button4HighestSkillPointDifficulty.lowercased()
            button4Record.skillPointRate = oldRecord.button4HighestSkillPointRate.rateConvertToDouble
            button4Record.skillPointNote = oldRecord.button4HighestSkillPointNote.noteAbbreviation
            recordInfo.button4 = button4Record
            button5NormalRecord.rank = oldRecord.nm5Rank == "-" ? "" : oldRecord.nm5Rank
            button5NormalRecord.rate = oldRecord.nm5Rate.rateConvertToDouble
            button5NormalRecord.note = oldRecord.nm5Note.noteAbbreviation
            button5Record.normal = button5NormalRecord
            button5HardRecord.rank = oldRecord.hd5Rank == "-" ? "" : oldRecord.hd5Rank
            button5HardRecord.rate = oldRecord.hd5Rate.rateConvertToDouble
            button5HardRecord.note = oldRecord.hd5Note.noteAbbreviation
            button5Record.hard = button5HardRecord
            button5MaximumRecord.rank = oldRecord.mx5Rank == "-" ? "" : oldRecord.mx5Rank
            button5MaximumRecord.rate = oldRecord.mx5Rate.rateConvertToDouble
            button5MaximumRecord.note = oldRecord.mx5Note.noteAbbreviation
            button5Record.maximum = button5MaximumRecord
            button5Record.skillPoint = oldRecord.button5SkillPoint
            button5Record.skillPointDifficulty = oldRecord.button5HighestSkillPointDifficulty.lowercased()
            button5Record.skillPointRate = oldRecord.button5HighestSkillPointRate.rateConvertToDouble
            button5Record.skillPointNote = oldRecord.button5HighestSkillPointNote.noteAbbreviation
            recordInfo.button5 = button5Record
            button6NormalRecord.rank = oldRecord.nm6Rank == "-" ? "" : oldRecord.nm6Rank
            button6NormalRecord.rate = oldRecord.nm6Rate.rateConvertToDouble
            button6NormalRecord.note = oldRecord.nm6Note.noteAbbreviation
            button6Record.normal = button6NormalRecord
            button6HardRecord.rank = oldRecord.hd6Rank == "-" ? "" : oldRecord.hd6Rank
            button6HardRecord.rate = oldRecord.hd6Rate.rateConvertToDouble
            button6HardRecord.note = oldRecord.hd6Note.noteAbbreviation
            button6Record.hard = button6HardRecord
            button6MaximumRecord.rank = oldRecord.mx6Rank == "-" ? "" : oldRecord.mx6Rank
            button6MaximumRecord.rate = oldRecord.mx6Rate.rateConvertToDouble
            button6MaximumRecord.note = oldRecord.mx6Note.noteAbbreviation
            button6Record.maximum = button6MaximumRecord
            button6Record.skillPoint = oldRecord.button6SkillPoint
            button6Record.skillPointDifficulty = oldRecord.button6HighestSkillPointDifficulty.lowercased()
            button6Record.skillPointRate = oldRecord.button6HighestSkillPointRate.rateConvertToDouble
            button6Record.skillPointNote = oldRecord.button6HighestSkillPointNote.noteAbbreviation
            recordInfo.button6 = button6Record
            button8NormalRecord.rank = oldRecord.nm8Rank == "-" ? "" : oldRecord.nm8Rank
            button8NormalRecord.rate = oldRecord.nm8Rate.rateConvertToDouble
            button8NormalRecord.note = oldRecord.nm8Note.noteAbbreviation
            button8Record.normal = button8NormalRecord
            button8HardRecord.rank = oldRecord.hd8Rank == "-" ? "" : oldRecord.hd8Rank
            button8HardRecord.rate = oldRecord.hd8Rate.rateConvertToDouble
            button8HardRecord.note = oldRecord.hd8Note.noteAbbreviation
            button8Record.hard = button8HardRecord
            button8MaximumRecord.rank = oldRecord.mx8Rank == "-" ? "" : oldRecord.mx8Rank
            button8MaximumRecord.rate = oldRecord.mx8Rate.rateConvertToDouble
            button8MaximumRecord.note = oldRecord.mx8Note.noteAbbreviation
            button8Record.maximum = button8MaximumRecord
            button8Record.skillPoint = oldRecord.button8SkillPoint
            button8Record.skillPointDifficulty = oldRecord.button8HighestSkillPointDifficulty.lowercased()
            button8Record.skillPointRate = oldRecord.button8HighestSkillPointRate.rateConvertToDouble
            button8Record.skillPointNote = oldRecord.button8HighestSkillPointNote.noteAbbreviation
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
          RecordInfo.add(recordInfo)
        }
        Skill.refresh()
        SVProgressHUD.dismiss()
        guard let next = UIViewController.instantiate(storyboard: "Performance", identifier: "PerformanceNavigationController") else { return }
        next.modalTransitionStyle = .crossDissolve
        self.present(next, animated: true, completion: nil)
      }
      .present(to: self)
  }
  
  private func plusCount() {
    DispatchQueue.main.sync { [weak self] in
      self?.count += 1
    }
  }
}
