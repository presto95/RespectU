//
//  DownloadViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 29..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import SVProgressHUD
import SwiftKeychainWrapper

/// The view controller for downloading various data.
final class DownloadViewController: UIViewController {
  
  // MARK: Property.
  
  /// The api service.
  private let apiService: APIServiceType = APIService()
  
  /// The 'download data' label.
  @IBOutlet private weak var downloadDataLabel: UILabel!
  
  /// The 'download data' button.
  @IBOutlet private weak var downloadDataButton: UIButton!
  
  /// The 'download record' label.
  @IBOutlet private weak var downloadRecordLabel: UILabel!
  
  /// The 'download record' button.
  @IBOutlet private weak var downloadRecordButton: UIButton!
  
  /// The boolean value indicating whether the requested version is valid to request data.
  private var isVersionValid: Bool = false {
    didSet {
      if isVersionValid {
        SVProgressHUD.show()
        apiService.requestSongs(bySeries: nil, completion: songRequestHandler)
        apiService.requestMissions(bySeries: nil, completion: missionRequestHandler)
        apiService.requestTrophies(bySeries: nil, completion: trophyRequestHandler)
        apiService.requestAchievements(byType: nil, completion: achievementRequestHandler)
        apiService.requestTips(completion: tipRequestHandler)
        apiService.requestVersions(completion: versionRequestHandler)
      }
    }
  }
  
  /// The boolean value indicating wheter the request about song is finished.
  private var isSongRequestFinished: Bool = false
  
  /// The boolean value indicating wheter the request about mission is finished.
  private var isMissionRequestFinished: Bool = false
  
  /// The boolean value indicating wheter the request about trophy is finished.
  private var isTrophyRequestFinished: Bool = false
  
  /// The boolean value indicating wheter the request about achievement is finished.
  private var isAchievementRequestFinished: Bool = false
  
  /// The boolean value indicating wheter the request about tip is finished.
  private var isTipRequestFinished: Bool = false
  
  /// The boolean value indicating wheter the request about version is finished.
  private var isVersionRequestFinished: Bool = false
  
  /// The boolean value indicating wheter the request about record is finished.
  private var isRecordRequestFinished: Bool = false
  
  /// The number of requests.
  private var numberOfRequests = 0 {
    didSet {
      if numberOfRequests == 6 {
        SVProgressHUD.dismiss()
        if isAllRequestFinished {
          presentSuccessAlert()
        } else {
          presentFailureAlert()
        }
        numberOfRequests = 0
      }
    }
  }
  
  /// The number of requests about record.
  private var numberOfRecordRequests = 0 {
    didSet {
      if numberOfRecordRequests == 1 {
        SVProgressHUD.dismiss()
        if isRecordRequestFinished {
          presentSuccessAlert()
        } else {
          presentFailureAlert()
        }
        numberOfRecordRequests = 0
      }
    }
  }
  
  /// The boolean value indicating wheter all the requests are finished.
  private var isAllRequestFinished: Bool {
    if isSongRequestFinished,
      isMissionRequestFinished,
      isTrophyRequestFinished,
      isAchievementRequestFinished,
      isTipRequestFinished,
      isVersionRequestFinished {
      return true
    }
    return false
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
  }
  
  /// Configures initial settings.
  private func configure() {
    downloadDataLabel.text = L10n.updateWithLatestData
    downloadRecordLabel.text = L10n.getExportedPerformanceRecordData
    downloadDataButton.setTitle(L10n.download, for: [])
    downloadRecordButton.setTitle(L10n.download, for: [])
    downloadDataButton
      .addTarget(self, action: #selector(downloadDataButtonDidTap(_:)), for: .touchUpInside)
    downloadRecordButton
      .addTarget(self, action: #selector(downloadRecordButtonDidTap(_:)), for: .touchUpInside)
  }
  
  /// Tells the `sender` that the download data button is tapped.
  @objc private func downloadDataButtonDidTap(_ sender: UIButton) {
    apiService.requestVersions(completion: versionCheckHandler)
  }
  
  /// Tells the `sender` that the download record button is tapped.
  @objc private func downloadRecordButtonDidTap(_ sender: UIButton) {
    let id = KeychainWrapper.standard.string(forKey: "id") ?? ""
    if id.isEmpty {
      UIAlertController
        .alert(title: "", message: L10n.logInFirst)
        .action(title: L10n.ok)
        .present(to: self)
    } else {
      let message
        = L10n.ifThereIsNoDataOnTheServerTheRecordedPerformanceInformationCanBeInitialized
      UIAlertController
        .alert(title: L10n.warning, message: message)
        .action(title: L10n.ok, style: .destructive) { [weak self] _ in
          guard let self = self else { return }
          DispatchQueue.main.async {
            SVProgressHUD.show()
          }
          self.apiService.requestRecords(id: id, completion: self.recordRequestHandler)
        }
        .action(title: L10n.cancel, style: .cancel)
        .present(to: self)
    }
  }
  
  /// Tells the `sender` that the cancel button is tapped.
  @IBAction private func cancelButtonDidTap(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
}

// MARK: - Request Handler

private extension DownloadViewController {
  
  /// Handler for song request.
  ///
  /// - Parameters:
  ///   - response: The song response.
  ///   - error:    The passed error.
  func songRequestHandler(response: SongResponse?, error: Error?) {
    if let error = error {
      incrementNumberOfRequests()
      present(UIAlertController.makeErrorAlert(error), animated: true, completion: nil)
      return
    }
    guard let response = response else { return }
    let downloadedSongs = response.songs
    let results = SongInfo.fetch()
    for downloadedSong in downloadedSongs {
      let predicate = NSPredicate(format: "%K == %@",
                                  #keyPath(SongInfo.title.english),
                                  downloadedSong.title.english)
      if let result = results.filter(predicate).first {
        SongInfo.update(downloadedSong, to: result)
      } else {
        SongInfo.add(downloadedSong)
        let recordInfo = RecordInfo()
        let titleInfo = LanguageInfo()
        titleInfo.english = downloadedSong.title.english
        titleInfo.korean = downloadedSong.title.korean
        recordInfo.title = titleInfo
        recordInfo.series = downloadedSong.series
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
        RecordInfo.add(recordInfo)
      }
    }
    Utils.refreshSkillPoints()
    isSongRequestFinished = true
    incrementNumberOfRequests()
  }
  
  /// Handler for mission request.
  ///
  /// - Parameters:
  ///   - response: The mission response.
  ///   - error:    The passed error.
  func missionRequestHandler(response: MissionResponse?, error: Error?) {
    if let error = error {
      incrementNumberOfRequests()
      present(UIAlertController.makeErrorAlert(error), animated: true, completion: nil)
      return
    }
    guard let response = response else { return }
    let downloadedMissions = response.missions
    let results = MissionInfo.fetch()
    for downloadedMission in downloadedMissions {
      let predicate = NSPredicate(format: "%K == %@",
                                  #keyPath(MissionInfo.title),
                                  downloadedMission.title)
      if let result = results.filter(predicate).first {
        MissionInfo.update(downloadedMission, to: result)
      } else {
        MissionInfo.add(downloadedMission)
      }
    }
    isMissionRequestFinished = true
    incrementNumberOfRequests()
  }
  
  /// Handler for trophy request.
  ///
  /// - Parameters:
  ///   - response: The trophy response.
  ///   - error:    The passed error.
  func trophyRequestHandler(response: TrophyResponse?, error: Error?) {
    if let error = error {
      incrementNumberOfRequests()
      present(UIAlertController.makeErrorAlert(error), animated: true, completion: nil)
      return
    }
    guard let response = response else { return }
    let downloadedTrophies = response.trophies
    let results = TrophyInfo.fetch()
    for downloadedTrophy in downloadedTrophies {
      let predicate = NSPredicate(format: "%K == %@",
                                  #keyPath(TrophyInfo.image),
                                  downloadedTrophy.image)
      if let result = results.filter(predicate).first {
        TrophyInfo.update(downloadedTrophy, to: result)
      } else {
        TrophyInfo.add(downloadedTrophy)
      }
    }
    isTrophyRequestFinished = true
    incrementNumberOfRequests()
  }
  
  /// Handler for achievement request.
  ///
  /// - Parameters:
  ///   - response: The achievement response.
  ///   - error:    The passed error.
  func achievementRequestHandler(response: AchievementResponse?, error: Error?) {
    if let error = error {
      incrementNumberOfRequests()
      present(UIAlertController.makeErrorAlert(error), animated: true, completion: nil)
      return
    }
    guard let response = response else { return }
    let downloadedAchievements = response.achievements
    let results = AchievementInfo.fetch(byType: .all)
    for downloadedAchievement in downloadedAchievements {
      let predicate = NSPredicate(format: "%K == %@ AND %K == %@",
                                  #keyPath(AchievementInfo.item.english),
                                  downloadedAchievement.item.english,
                                  #keyPath(AchievementInfo.type),
                                  downloadedAchievement.type)
      if let result = results.filter(predicate).first {
        AchievementInfo.update(downloadedAchievement, to: result)
      } else {
        AchievementInfo.add(downloadedAchievement)
      }
    }
    isAchievementRequestFinished = true
    incrementNumberOfRequests()
  }
  
  /// Handler for tip request.
  ///
  /// - Parameters:
  ///   - response: The tip response.
  ///   - error:    The passed error.
  func tipRequestHandler(response: TipResponse?, error: Error?) {
    if let error = error {
      incrementNumberOfRequests()
      present(UIAlertController.makeErrorAlert(error), animated: true, completion: nil)
      return
    }
    guard let response = response else { return }
    let downloadedTips = response.tips
    let results = TipInfo.fetch()
    for downloadedTip in downloadedTips {
      let predicate = NSPredicate(format: "%K == %@",
                                  #keyPath(TipInfo.title.english),
                                  downloadedTip.title.english)
      if let result = results.filter(predicate).first {
        TipInfo.update(downloadedTip, to: result)
      } else {
        TipInfo.add(downloadedTip)
      }
    }
    isTipRequestFinished = true
    incrementNumberOfRequests()
  }
  
  /// Handler for version request.
  ///
  /// - Parameters:
  ///   - response: The version response.
  ///   - error:    The passed error.
  func versionRequestHandler(response: VersionResponse?, error: Error?) {
    if let error = error {
      incrementNumberOfRequests()
      present(UIAlertController.makeErrorAlert(error), animated: true, completion: nil)
      return
    }
    guard let response = response else { return }
    if let result = VersionInfo.fetch().first {
      VersionInfo.update(response, to: result)
    } else {
      VersionInfo.add(response)
    }
    isVersionRequestFinished = true
    incrementNumberOfRequests()
  }
  
  /// Handler for record request.
  ///
  /// - Parameters:
  ///   - response: The record response.
  ///   - error:    The passed error.
  func recordRequestHandler(response: RecordResponse?, error: Error?) {
    if let error = error {
      incrementNumberOfRecordRequests()
      present(UIAlertController.makeErrorAlert(error), animated: true, completion: nil)
      return
    }
    guard let response = response else { return }
    let results = RecordInfo.fetch()
    let records = response.records
    for record in records {
      let predicate = NSPredicate(format: "%K == %@",
                                  #keyPath(RecordInfo.title.english),
                                  record.title.english)
      guard let result = results.filter(predicate).first else { continue }
      RecordInfo.update(record, to: result)
    }
    isRecordRequestFinished = true
    incrementNumberOfRecordRequests()
  }
  
  /// Handler for version check request.
  ///
  /// - Parameters:
  ///   - response: The version response.
  ///   - error:    The passed error.
  func versionCheckHandler(response: VersionResponse?, error: Error?) {
    if let error = error {
      present(UIAlertController.makeErrorAlert(error), animated: true, completion: nil)
      return
    }
    guard let response = response else { return }
    if response.clientVersion != version {
      let message = L10n.newVersionReleasedPleaseUseItAfterUpdating
      DispatchQueue.main.async {
        UIAlertController
          .alert(title: "", message: message)
          .action(title: L10n.update) { _ in
            guard let url = URL(string: "itms-apps://itunes.apple.com/app/id1291664067")
              else { return }
            guard #available(iOS 10, *) else {
              UIApplication.shared.openURL(url)
              return
            }
            UIApplication.shared.open(url, options: [:])
          }
          .action(title: L10n.cancel, style: .cancel)
          .present(to: self)
      }
    } else {
      isVersionValid = true
    }
  }
}

// MARK: - Private Method

private extension DownloadViewController {
  
  /// Presents the alert representing the task is completed successfully.
  func presentSuccessAlert() {
    UIAlertController
      .alert(title: "", message: L10n.yourDataHasBeenSuccessfullyDownloaded)
      .action(title: L10n.ok) { [weak self] _ in
        self?.parent?.dismiss(animated: true, completion: nil)
      }
      .present(to: self)
  }
  
  /// Presents the alert representing the task is completed with error.
  func presentFailureAlert() {
    UIAlertController
      .alert(title: "", message: L10n.networkError)
      .action(title: L10n.ok) { [weak self] _ in
        self?.numberOfRequests = 0
      }
      .present(to: self)
  }
  
  /// Increments the number of requests.
  func incrementNumberOfRequests() {
    DispatchQueue.main.sync { [weak self] in
      self?.numberOfRequests += 1
    }
  }
  
  /// Increments the number of record request.
  func incrementNumberOfRecordRequests() {
    DispatchQueue.main.sync { [weak self] in
      self?.numberOfRecordRequests += 1
    }
  }
}
