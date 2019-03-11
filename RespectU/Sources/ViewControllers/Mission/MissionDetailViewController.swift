//
//  MissionDetail2ViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 3..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

/// The mission detail view controller.
final class MissionDetailViewController: UIViewController {
  
  /// The `enum` defines constants.
  private enum Constant {
    
    /// The favorite bpm of user.
    static let myBPM = UserDefaults.standard.double(forKey: "bpm")
    
    /// `RANDOM`.
    static let random = "RANDOM"
  }
  
  // MARK: Property
  
  /// The passed mission information.
  var missionInfo: MissionInfo!
  
  /// The boolean value indicating whether the first song exists.
  var isSong1Exists: Bool {
    return missionInfo.stage1 != nil
  }
  
  /// The boolean value indicating whether the second song exists.
  var isSong2Exists: Bool {
    return missionInfo.stage2 != nil
  }
  
  /// The boolean value indicating whether the third song exists.
  var isSong3Exists: Bool {
    return missionInfo.stage3 != nil
  }
  
  /// The boolean value indicating whether the fourth song exists.
  var isSong4Exists: Bool {
    return missionInfo.stage4 != nil
  }
  
  /// The boolean value indicating whether the fifth song exists.
  var isSong5Exists: Bool {
    return missionInfo.stage5 != nil
  }
  
  /// The boolean value indicating whether the sixth song exists.
  var isSong6Exists: Bool {
    return missionInfo.stage6 != nil
  }
  
  /// The title label.
  @IBOutlet private weak var titleLabel: UILabel!
  
  /// The score limit label.
  @IBOutlet private weak var scoreLabel: UILabel!
  
  /// The fever limit label.
  @IBOutlet private weak var feverLabel: UILabel!
  
  /// The combo limit label.
  @IBOutlet private weak var comboLabel: UILabel!
  
  /// The rating limit label.
  @IBOutlet private weak var ratingLabel: UILabel!
  
  /// The break limit label.
  @IBOutlet private weak var breakLabel: UILabel!
  
  /// The button label about the first song.
  @IBOutlet private weak var song1ButtonLabel: UILabel!
  
  /// The button label about the second song.
  @IBOutlet private weak var song2ButtonLabel: UILabel!
  
  /// The button label about the third song.
  @IBOutlet private weak var song3ButtonLabel: UILabel!
  
  /// The button label about the fourth song.
  @IBOutlet private weak var song4ButtonLabel: UILabel!
  
  /// The button label about the fifth song.
  @IBOutlet private weak var song5ButtonLabel: UILabel!
  
  /// The button label about the sixth song.
  @IBOutlet private weak var song6ButtonLabel: UILabel!
  
  /// The difficulty label about the first song.
  @IBOutlet private weak var song1DifficultyLabel: UILabel!
  
  /// The difficulty label about the second song.
  @IBOutlet private weak var song2DifficultyLabel: UILabel!
  
  /// The difficulty label about the third song.
  @IBOutlet private weak var song3DifficultyLabel: UILabel!
  
  /// The difficulty label about the fourth song.
  @IBOutlet private weak var song4DifficultyLabel: UILabel!
  
  /// The difficulty label about the fifth song.
  @IBOutlet private weak var song5DifficultyLabel: UILabel!
  
  /// The difficulty label about the sixth song.
  @IBOutlet private weak var song6DifficultyLabel: UILabel!
  
  /// The title label about the first song.
  @IBOutlet private weak var song1TitleLabel: UILabel!
  
  /// The title label about the second song.
  @IBOutlet private weak var song2TitleLabel: UILabel!
  
  /// The title label about the third song.
  @IBOutlet private weak var song3TitleLabel: UILabel!
  
  /// The title label about the fourth song.
  @IBOutlet private weak var song4TitleLabel: UILabel!
  
  /// The title label about the fifth song.
  @IBOutlet private weak var song5TitleLabel: UILabel!
  
  /// The title label about the sixth song.
  @IBOutlet private weak var song6TitleLabel: UILabel!
  
  /// The more button about the first song.
  @IBOutlet private weak var song1MoreButton: UIButton!
  
  /// The more button about the second song.
  @IBOutlet private weak var song2MoreButton: UIButton!
  
  /// The more button about the third song.
  @IBOutlet private weak var song3MoreButton: UIButton!
  
  /// The more button about the fourth song.
  @IBOutlet private weak var song4MoreButton: UIButton!
  
  /// The more button about the fifth song.
  @IBOutlet private weak var song5MoreButton: UIButton!
  
  /// The more button about the sixth song.
  @IBOutlet private weak var song6MoreButton: UIButton!
  
  /// The effector label.
  @IBOutlet private weak var effectorLabel: UILabel!
  
  /// The reward label.
  @IBOutlet private weak var rewardLabel: UILabel!
  
  // MARK: Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setVisibilityOfSubviews()
    titleLabel.text = missionInfo.title
    scoreLabel.text = missionInfo.score == 0 ? "-" : "\(missionInfo.score)"
    feverLabel.text = missionInfo.fever == 0 ? "-" : "X\(missionInfo.fever)"
    comboLabel.text = missionInfo.combo == 0 ? "-" : "\(missionInfo.combo)"
    ratingLabel.text = missionInfo.rate == 0 ? "-" : "\(missionInfo.rate)%"
    breakLabel.text = missionInfo.break == 0 ? "-" : "\(missionInfo.break)"
    effectorLabel.text = missionInfo.effector
    rewardLabel.text = missionInfo.localizedReward
    if let song = missionInfo.stage1 {
      song1ButtonLabel.text = song.button.uppercased()
      song1DifficultyLabel.text = song.difficulty.uppercased()
      song1TitleLabel.text = song.localizedTitle
    }
    if let song = missionInfo.stage2 {
      song2ButtonLabel.text = song.button.uppercased()
      song2DifficultyLabel.text = song.difficulty.uppercased()
      song2TitleLabel.text = song.localizedTitle
    }
    if let song = missionInfo.stage3 {
      song3ButtonLabel.text = song.button.uppercased()
      song3DifficultyLabel.text = song.difficulty.uppercased()
      song3TitleLabel.text = song.localizedTitle
    }
    if let song = missionInfo.stage4 {
      song4ButtonLabel.text = song.button.uppercased()
      song4DifficultyLabel.text = song.difficulty.uppercased()
      song4TitleLabel.text = song.localizedTitle
    }
    if let song = missionInfo.stage5 {
      song5ButtonLabel.text = song.button.uppercased()
      song5DifficultyLabel.text = song.difficulty.uppercased()
      song5TitleLabel.text = song.localizedTitle
    }
    if let song = missionInfo.stage6 {
      song6ButtonLabel.text = song.button.uppercased()
      song6DifficultyLabel.text = song.difficulty.uppercased()
      song6TitleLabel.text = song.localizedTitle
    }
  }
  
  @IBAction func cancelButtonDidTap(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func moreButtonDidTap(_ sender: UIButton) {
    switch sender.tag {
    case 0:
      presentMoreAlert(missionInfo.stage1)
    case 1:
      presentMoreAlert(missionInfo.stage2)
    case 2:
      presentMoreAlert(missionInfo.stage3)
    case 3:
      presentMoreAlert(missionInfo.stage4)
    case 4:
      presentMoreAlert(missionInfo.stage5)
    case 5:
      presentMoreAlert(missionInfo.stage6)
    default:
      break
    }
  }
}

// MARK: - Private Method

extension MissionDetailViewController {
  
  /// Presents alert that presenting more information.
  ///
  /// - Parameter stageInfo: The stage information about the mission.
  private func presentMoreAlert(_ stageInfo: MissionStageInfo?) {
    guard let englishTitle = stageInfo?.title?.english,
      let localizedTitle = stageInfo?.localizedTitle,
      let button = stageInfo?.buttonEnum, let difficulty = stageInfo?.difficultyEnum
      else { return }
    var level: Int?
    var bpm: Int = 0
    var changesSpeed: Bool = false
    if let songInfo = SongInfo.fetch(byTitle: englishTitle) {
      if let subBpm = songInfo.subBPM.value {
        bpm = subBpm
        changesSpeed = true
      } else {
        bpm = songInfo.bpm
      }
      if let buttonKeyPath = button.expansion {
        guard let buttonResult = songInfo.value(forKeyPath: buttonKeyPath) as? SongButtonInfo
          else { return }
        switch difficulty {
        case .normal:
          level = buttonResult.normal
        case .hard:
          level = buttonResult.hard
        case .maximum:
          level = buttonResult.maximum
        default:
          break
        }
      }
    }
    let speedString = { () -> String in
      if bpm != 0 {
        return Utils.convertToRecommendedSpeed(by: Constant.myBPM / Double(bpm)) ?? ""
      } else {
        return "??"
      }
    }()
    let levelString = { () -> String in
      if let level = level {
        return "\(level)"
      } else {
        return "??"
      }
    }()
    var message = "\(button.rawValue.uppercased()) "
      .appending("\(difficulty.rawValue.uppercased())\n\n")
      .appending(L10n.level)
      .appending("\n\(levelString)\n\n")
      .appending(L10n.speedRecommendation)
      .appending("\n\(speedString)")
    if changesSpeed {
      message += "\n" + L10n.speedVariation
    }
    DispatchQueue.main.async { [weak self] in
      UIAlertController
        .alert(title: localizedTitle, message: message)
        .action(title: L10n.ok)
        .present(to: self)
    }
  }
  
  /// Sets visibility of subviews.
  private func setVisibilityOfSubviews() {
    if !isSong1Exists {
      song1ButtonLabel.isHidden = true
      song1DifficultyLabel.isHidden = true
      song1TitleLabel.isHidden = true
      song1MoreButton.isHidden = true
    } else if missionInfo.stage1?.localizedTitle == Constant.random {
      song1MoreButton.isHidden = true
    }
    if !isSong2Exists {
      song2ButtonLabel.isHidden = true
      song2DifficultyLabel.isHidden = true
      song2TitleLabel.isHidden = true
      song2MoreButton.isHidden = true
    } else if missionInfo.stage2?.localizedTitle == Constant.random {
      song2MoreButton.isHidden = true
    }
    if !isSong3Exists {
      song3ButtonLabel.isHidden = true
      song3DifficultyLabel.isHidden = true
      song3TitleLabel.isHidden = true
      song3MoreButton.isHidden = true
    } else if missionInfo.stage3?.localizedTitle == Constant.random {
      song3MoreButton.isHidden = true
    }
    if !isSong4Exists {
      song4ButtonLabel.isHidden = true
      song4DifficultyLabel.isHidden = true
      song4TitleLabel.isHidden = true
      song4MoreButton.isHidden = true
    } else if missionInfo.stage4?.localizedTitle == Constant.random {
      song4MoreButton.isHidden = true
    }
    if !isSong5Exists {
      song5ButtonLabel.isHidden = true
      song5DifficultyLabel.isHidden = true
      song5TitleLabel.isHidden = true
      song5MoreButton.isHidden = true
    } else if missionInfo.stage5?.localizedTitle == Constant.random {
      song5MoreButton.isHidden = true
    }
    if !isSong6Exists {
      song6ButtonLabel.isHidden = true
      song6DifficultyLabel.isHidden = true
      song6TitleLabel.isHidden = true
      song6MoreButton.isHidden = true
    } else if missionInfo.stage6?.localizedTitle == Constant.random {
      song6MoreButton.isHidden = true
    }
  }
}
