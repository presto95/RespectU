//
//  StartViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 9. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import SVProgressHUD

/// The initializing view controller.
final class InitViewController: UIViewController {
  
  /// The api service.
  private let apiService: APIServiceType = APIService()
  
  /// The boolean value indicating whether song requests is finished.
  private var isSongRequestFinished: Bool = false
  
  /// The boolean value indicating whether mission requests is finished.
  private var isMissionRequestFinished: Bool = false
  
  /// The boolean value indicating whether trophy requests is finished.
  private var isTrophyRequestFinished: Bool = false
  
  /// The boolean value indicating whether achievement requests is finished.
  private var isAchievementRequestFinished: Bool = false
  
  /// The boolean value indicating whether tip requests is finished.
  private var isTipRequestFinished: Bool = false
  
  /// The boolean value indicating whether version requests is finished.
  private var isVersionRequestFinished: Bool = false
  
  /// The description label.
  @IBOutlet private weak var descriptionLabel: UILabel!
  
  /// The start button.
  @IBOutlet private weak var startButton: UIButton!
  
  /// The number of requests.
  var numberOfRequests = 0 {
    didSet {
      if numberOfRequests == 6 {
        SVProgressHUD.dismiss()
        if isAllRequestsFinished {
          presentSuccessAlert()
        } else {
          let error = NSError(domain: L10n.networkError, code: 0, userInfo: nil)
          present(UIAlertController.makeErrorAlert(error), animated: true, completion: nil)
        }
      }
    }
  }
  
  /// The boolean value indicating whether all requests are finished.
  var isAllRequestsFinished: Bool {
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
  
  // MARK: Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  /// Configures initial settings.
  private func setup() {
    descriptionLabel.text = L10n.downloadDataToStartTheApplication
    startButton.setTitle(L10n.download, for: [])
    startButton.addTarget(self, action: #selector(downloadButtonDidTap(_:)), for: .touchUpInside)
  }
  
  /// Tells the `sender` that the download button is tapped.
  @objc private func downloadButtonDidTap(_ sender: UIButton) {
    SVProgressHUD.show()
    apiService.requestSongs(bySeries: nil, completion: songRequestHandler)
    apiService.requestMissions(bySeries: nil, completion: missionRequestHandler)
    apiService.requestTrophies(bySeries: nil, completion: trophyRequestHandler)
    apiService.requestAchievements(byType: nil, completion: achievementRequestHandler)
    apiService.requestTips(completion: tipRequestHandler)
    apiService.requestVersions(completion: versionRequestHandler)
  }
}

// MARK: - Request Handler

private extension InitViewController {
  
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
    for song in response.songs {
      SongInfo.add(song)
    }
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
    for mission in response.missions {
      MissionInfo.add(mission)
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
    for trophy in response.trophies {
      TrophyInfo.add(trophy)
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
    for achievement in response.achievements {
      AchievementInfo.add(achievement)
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
    for tip in response.tips {
      TipInfo.add(tip)
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
    VersionInfo.add(response)
    isVersionRequestFinished = true
    incrementNumberOfRequests()
  }
}

// MARK: - Private Method

private extension InitViewController {
  
  /// Presents the alert representing the task is completed successfully.
  func presentSuccessAlert() {
    let results = SongInfo.fetch()
    let oldResults = OldRecordInfo.get()
    UIAlertController
      .alert(title: "", message: L10n.yourDataHasBeenSuccessfullyDownloaded)
      .action(title: L10n.ok) { [weak self] _ in
        guard let self = self else { return }
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
          if let oldRecord = oldResults.filter("title = %@ OR title = %@",
                                               result.title?.english ?? "",
                                               result.title?.korean ?? "").first {
            button4NormalRecord.rank = oldRecord.nm4Rank == "-" ? "" : oldRecord.nm4Rank
            button4NormalRecord.rate = Utils.convertToDouble(withPercent: oldRecord.nm4Rate)
            button4NormalRecord.note = Note(expansion: oldRecord.nm4Note)?.rawValue ?? ""
            button4Record.normal = button4NormalRecord
            button4HardRecord.rank = oldRecord.hd4Rank == "-" ? "" : oldRecord.hd4Rank
            button4HardRecord.rate = Utils.convertToDouble(withPercent: oldRecord.hd4Rate)
            button4HardRecord.note = Note(expansion: oldRecord.hd4Note)?.rawValue ?? ""
            button4Record.hard = button4HardRecord
            button4MaximumRecord.rank = oldRecord.mx4Rank == "-" ? "" : oldRecord.mx4Rank
            button4MaximumRecord.rate = Utils.convertToDouble(withPercent: oldRecord.mx4Rate)
            button4MaximumRecord.note = Note(expansion: oldRecord.mx4Note)?.rawValue ?? ""
            button4Record.maximum = button4MaximumRecord
            button4Record.skillPoint = oldRecord.button4SkillPoint
            button4Record.skillPointDifficulty
              = oldRecord.button4HighestSkillPointDifficulty.lowercased()
            button4Record.skillPointRate
              = Utils.convertToDouble(withPercent: oldRecord.button4HighestSkillPointRate)
            button4Record.skillPointNote
              = Note(expansion: oldRecord.button4HighestSkillPointNote)?.rawValue ?? ""
            recordInfo.button4 = button4Record
            button5NormalRecord.rank = oldRecord.nm5Rank == "-" ? "" : oldRecord.nm5Rank
            button5NormalRecord.rate = Utils.convertToDouble(withPercent: oldRecord.nm5Rate)
            button5NormalRecord.note = Note(expansion: oldRecord.nm5Note)?.rawValue ?? ""
            button5Record.normal = button5NormalRecord
            button5HardRecord.rank = oldRecord.hd5Rank == "-" ? "" : oldRecord.hd5Rank
            button5HardRecord.rate = Utils.convertToDouble(withPercent: oldRecord.hd5Rate)
            button5HardRecord.note = Note(expansion: oldRecord.hd5Note)?.rawValue ?? ""
            button5Record.hard = button5HardRecord
            button5MaximumRecord.rank = oldRecord.mx5Rank == "-" ? "" : oldRecord.mx5Rank
            button5MaximumRecord.rate = Utils.convertToDouble(withPercent: oldRecord.mx5Rate)
            button5MaximumRecord.note = Note(expansion: oldRecord.mx5Note)?.rawValue ?? ""
            button5Record.maximum = button5MaximumRecord
            button5Record.skillPoint = oldRecord.button5SkillPoint
            button5Record.skillPointDifficulty
              = oldRecord.button5HighestSkillPointDifficulty.lowercased()
            button5Record.skillPointRate
              = Utils.convertToDouble(withPercent: oldRecord.button5HighestSkillPointRate)
            button5Record.skillPointNote
              = Note(expansion: oldRecord.button5HighestSkillPointNote)?.rawValue ?? ""
            recordInfo.button5 = button5Record
            button6NormalRecord.rank = oldRecord.nm6Rank == "-" ? "" : oldRecord.nm6Rank
            button6NormalRecord.rate = Utils.convertToDouble(withPercent: oldRecord.nm6Rate)
            button6NormalRecord.note = Note(expansion: oldRecord.nm6Note)?.rawValue ?? ""
            button6Record.normal = button6NormalRecord
            button6HardRecord.rank = oldRecord.hd6Rank == "-" ? "" : oldRecord.hd6Rank
            button6HardRecord.rate = Utils.convertToDouble(withPercent: oldRecord.hd6Rate)
            button6HardRecord.note = Note(expansion: oldRecord.hd6Note)?.rawValue ?? ""
            button6Record.hard = button6HardRecord
            button6MaximumRecord.rank = oldRecord.mx6Rank == "-" ? "" : oldRecord.mx6Rank
            button6MaximumRecord.rate = Utils.convertToDouble(withPercent: oldRecord.mx6Rate)
            button6MaximumRecord.note = Note(expansion: oldRecord.mx6Note)?.rawValue ?? ""
            button6Record.maximum = button6MaximumRecord
            button6Record.skillPoint = oldRecord.button6SkillPoint
            button6Record.skillPointDifficulty
              = oldRecord.button6HighestSkillPointDifficulty.lowercased()
            button6Record.skillPointRate
              = Utils.convertToDouble(withPercent: oldRecord.button6HighestSkillPointRate)
            button6Record.skillPointNote
              = Note(expansion: oldRecord.button6HighestSkillPointNote)?.rawValue ?? ""
            recordInfo.button6 = button6Record
            button8NormalRecord.rank = oldRecord.nm8Rank == "-" ? "" : oldRecord.nm8Rank
            button8NormalRecord.rate = Utils.convertToDouble(withPercent: oldRecord.nm8Rate)
            button8NormalRecord.note = Note(expansion: oldRecord.nm8Note)?.rawValue ?? ""
            button8Record.normal = button8NormalRecord
            button8HardRecord.rank = oldRecord.hd8Rank == "-" ? "" : oldRecord.hd8Rank
            button8HardRecord.rate = Utils.convertToDouble(withPercent: oldRecord.hd8Rate)
            button8HardRecord.note = Note(expansion: oldRecord.hd8Note)?.rawValue ?? ""
            button8Record.hard = button8HardRecord
            button8MaximumRecord.rank = oldRecord.mx8Rank == "-" ? "" : oldRecord.mx8Rank
            button8MaximumRecord.rate = Utils.convertToDouble(withPercent: oldRecord.mx8Rate)
            button8MaximumRecord.note = Note(expansion: oldRecord.mx8Note)?.rawValue ?? ""
            button8Record.maximum = button8MaximumRecord
            button8Record.skillPoint = oldRecord.button8SkillPoint
            button8Record.skillPointDifficulty
              = oldRecord.button8HighestSkillPointDifficulty.lowercased()
            button8Record.skillPointRate
              = Utils.convertToDouble(withPercent: oldRecord.button8HighestSkillPointRate)
            button8Record.skillPointNote
              = Note(expansion: oldRecord.button8HighestSkillPointNote)?.rawValue ?? ""
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
        Utils.refreshSkillPoints()
        SVProgressHUD.dismiss()
        let controller
          = StoryboardScene.Performance.performanceNavigationController.instantiate().then {
            $0.modalTransitionStyle = .crossDissolve
        }
        self.present(controller, animated: true, completion: nil)
      }
      .present(to: self)
  }
  
  /// Increments number of requests.
  func incrementNumberOfRequests() {
    DispatchQueue.main.sync { [weak self] in
      self?.numberOfRequests += 1
    }
  }
}
