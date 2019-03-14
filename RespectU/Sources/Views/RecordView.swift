//
//  RecordView.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import RealmSwift

/// The `protocol` that defines delegate methods of the `RecordView`.
protocol RecordViewDelegate: class {
  
  /// Tells the delegate that the type button is tapped.
  ///
  /// - Parameters:
  ///   - view:   The view requesting this information.
  ///   - button: The button which is tapped.
  func recordView(_ view: RecordView, didTapTypeButton button: UIButton)
  
  /// Tells the delegate that the cancel button is tapped.
  ///
  /// - Parameters:
  ///   - view:   The view requesting this information.
  ///   - button: The button which is tapped.
  func recordView(_ view: RecordView, didTapCancelButton button: UIButton)
  
  /// Tells the delegate that the rank button is tapped in `difficulty` in `currentButton`.
  ///
  /// - Parameters:
  ///   - view:           The view requesting this information.
  ///   - button:         The button which is tapped.
  ///   - difficulty:     The specific difficulty.
  ///   - currentButton:  The passed current button.
  func recordView(_ view: RecordView,
                  didTapRankRecordButton button: UIButton,
                  inDifficulty difficulty: Difficulty,
                  inCurrentButton currentButton: Button)
  
  /// Tells the delegate that the rating button is tapped in `difficulty` in `currentButton`.
  ///
  /// - Parameters:
  ///   - view:           The view requesting this information.
  ///   - button:         The button which is tapped.
  ///   - difficulty:     The specific difficulty.
  ///   - currentButton:  The passed current button.
  func recordView(_ view: RecordView,
                  didTapRatingRecordButton button: UIButton,
                  inDifficulty difficulty: Difficulty,
                  inCurrentButton currentButton: Button)
  
  /// Tells the delegate that the note button is tapped in `difficulty` in `currentButton`.
  ///
  /// - Parameters:
  ///   - view:           The view requesting this information.
  ///   - button:         The button which is tapped.
  ///   - difficulty:     The specific difficulty.
  ///   - currentButton:  The passed current button.
  func recordView(_ view: RecordView,
                  didTapNoteRecordButton button: UIButton,
                  inDifficulty difficulty: Difficulty,
                  inCurrentButton currentButton: Button)
}

/// The record view.
final class RecordView: UIView {
  
  /// The `enum` that defines various formats.
  private enum Format {
    
    /// The format for representing the rating.
    static let rating = "%05.2f%%"
  }
  
  /// The object that acts as the delegate of the `RecordView`.
  weak var delegate: RecordViewDelegate?
  
  /// The title label.
  @IBOutlet private weak var titleLabel: UILabel!
  
  /// The skill point label.
  @IBOutlet private weak var skillPointLabel: UILabel!
  
  /// The button representing the current button.
  @IBOutlet private weak var buttonButton: UIButton!
  
  /// The button representing the rank of the normal difficulty.
  @IBOutlet private weak var normalRankButton: UIButton!
  
  /// The button representing the rating of the normal difficulty.
  @IBOutlet private weak var normalRatingButton: UIButton!
  
  /// The button representing the note of the normal difficulty.
  @IBOutlet private weak var normalNoteButton: UIButton!
  
  /// The button representing the rank of the hard difficulty.
  @IBOutlet private weak var hardRankButton: UIButton!
  
  /// The button representing the rating of the hard difficulty.
  @IBOutlet private weak var hardRatingButton: UIButton!
  
  /// The button representing the note of the hard difficulty.
  @IBOutlet private weak var hardNoteButton: UIButton!
  
  /// The button representing the rank of the maximum difficulty.
  @IBOutlet private weak var maximumRankButton: UIButton!
  
  /// The button representing the rating of the maximum difficulty.
  @IBOutlet private weak var maximumRatingButton: UIButton!
  
  /// The button representing the note of the maximum difficulty.
  @IBOutlet private weak var maximumNoteButton: UIButton!
  
  /// The cancel button.
  @IBOutlet private weak var cancelButton: UIButton!
  
  /// The normal label.
  @IBOutlet private weak var normalLabel: UILabel!
  
  /// The hard label.
  @IBOutlet private weak var hardLabel: UILabel!
  
  /// The maximum label.
  @IBOutlet private weak var maximumLabel: UILabel!
  
  /// The ranking label.
  @IBOutlet private weak var rankingLabel: UILabel!
  
  /// The current button.
  private var currentButton: Button {
    return Button(rawValue: (buttonButton.title(for: .normal) ?? "4b").lowercased()) ?? .button4
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configure()
  }
  
  /// Configures initial settings.
  private func configure() {
    layer.do {
      $0.borderWidth = 1
      $0.cornerRadius = 15
      $0.borderColor = UIColor.lightGray.cgColor
    }
    cancelButton.do {
      $0.setTitle(L10n.cancel, for: .normal)
      $0.addTarget(self, action: #selector(cancelButtonDidTap(_:)), for: .touchUpInside)
    }
  }
  
  /// Tells the `sender` that the record button is tapped.
  @IBAction private func recordButtonDidTap(_ sender: UIButton) {
    switch sender.tag {
    case 0:
      delegate?.recordView(self,
                           didTapRankRecordButton: sender,
                           inDifficulty: .normal,
                           inCurrentButton: currentButton)
    case 1:
      delegate?.recordView(self,
                           didTapRatingRecordButton: sender,
                           inDifficulty: .normal,
                           inCurrentButton: currentButton)
    case 2:
      delegate?.recordView(self,
                           didTapNoteRecordButton: sender,
                           inDifficulty: .normal,
                           inCurrentButton: currentButton)
    case 3:
      delegate?.recordView(self,
                           didTapRankRecordButton: sender,
                           inDifficulty: .hard,
                           inCurrentButton: currentButton)
    case 4:
      delegate?.recordView(self,
                           didTapRatingRecordButton: sender,
                           inDifficulty: .hard,
                           inCurrentButton: currentButton)
    case 5:
      delegate?.recordView(self,
                           didTapNoteRecordButton: sender,
                           inDifficulty: .hard,
                           inCurrentButton: currentButton)
    case 6:
      delegate?.recordView(self,
                           didTapRankRecordButton: sender,
                           inDifficulty: .maximum,
                           inCurrentButton: currentButton)
    case 7:
      delegate?.recordView(self,
                           didTapRatingRecordButton: sender,
                           inDifficulty: .maximum,
                           inCurrentButton: currentButton)
    case 8:
      delegate?.recordView(self,
                           didTapNoteRecordButton: sender,
                           inDifficulty: .maximum,
                           inCurrentButton: currentButton)
    default:
      break
    }
  }
  
  /// Tells the `sender` that the type button is tapped.
  @IBAction private func typeButtonDidTap(_ sender: UIButton) {
    delegate?.recordView(self, didTapTypeButton: sender)
  }
  
  /// Tells the `sender` that the cancel button is tapped.
  @IBAction private func cancelButtonDidTap(_ sender: UIButton) {
    delegate?.recordView(self, didTapCancelButton: sender)
  }
  
  /// Updates ranking with `recordInfo` and `button` and update skill point labels.
  ///
  /// - Parameters:
  ///   - recordInfo: The record information will be updated.
  ///   - button:     The specific button.
  func updateRankingAndSkillPointLabel(with recordInfo: RecordInfo, inButton button: Button) {
    updateSkillPointLabel(with: recordInfo, inButton: button)
    updateRankingLabel(withTitle: recordInfo.localizedTitle, inButton: button)
  }
  
  /// Reloads buttons and labels with `recordInfo` and `button`.
  ///
  /// - Parameters:
  ///   - recordInfo: The record information.
  ///   - button:     The specific button.
  func reloadButtonsAndLabels(with recordInfo: RecordInfo, inButton button: Button) {
    let predicate = NSPredicate(format: "%K == %@",
                                #keyPath(SongInfo.title.english),
                                recordInfo.title?.english ?? "")
    guard let songResult = SongInfo.fetch().filter(predicate).first else { return }
    buttonButton.setTitle(button.rawValue.uppercased(), for: [])
    titleLabel.text = recordInfo.localizedTitle
    let normalButtons = [normalRankButton, normalRatingButton, normalNoteButton]
    let hardButtons = [hardRankButton, hardRatingButton, hardNoteButton]
    let maximumButtons = [maximumRankButton, maximumRatingButton, maximumNoteButton]
    for index in 0..<3 {
      normalButtons[index]?.isEnabled = true
      hardButtons[index]?.isEnabled = true
      maximumButtons[index]?.isEnabled = true
    }
    let buttonExpansion = button.expansion ?? ""
    updateRankingLabel(withTitle: recordInfo.localizedTitle, inButton: button)
    updateSkillPointLabel(with: recordInfo, inButton: button)
    guard let songButtonKeyPath = songResult.value(forKeyPath: buttonExpansion) as? SongButtonInfo
      else { return }
    if songButtonKeyPath.normal == 0 {
      for button in normalButtons {
        button?.isEnabled = false
        button?.setTitle(L10n.none, for: [])
      }
      normalLabel.text = "-"
    } else {
      guard let recordButtonKeyPath
        = recordInfo.value(forKeyPath: buttonExpansion) as? RecordButtonInfo
        else { return }
      let rank = recordButtonKeyPath.normal?.rank ?? ""
      let rating = recordButtonKeyPath.normal?.rate ?? 0
      let note = recordButtonKeyPath.normal?.note ?? ""
      normalRankButton.setTitle(rank == "" ? "-" : rank, for: [])
      normalRatingButton
        .setTitle(rating == 0 ? "-" : String(format: Format.rating, rating), for: [])
      normalNoteButton.setTitle(note == "" ? "-" : note, for: [])
      normalLabel.text = "\(songButtonKeyPath.normal)"
    }
    if songButtonKeyPath.hard == 0 {
      for button in hardButtons {
        button?.isEnabled = false
        button?.setTitle(L10n.none, for: [])
      }
      hardLabel.text = "-"
    } else {
      guard let recordButtonKeyPath
        = recordInfo.value(forKeyPath: buttonExpansion) as? RecordButtonInfo
        else { return }
      let rank = recordButtonKeyPath.hard?.rank ?? ""
      let rating = recordButtonKeyPath.hard?.rate ?? 0
      let note = recordButtonKeyPath.hard?.note ?? ""
      hardRankButton.setTitle(rank == "" ? "-" : rank, for: [])
      hardRatingButton
        .setTitle(rating == 0 ? "-" : String(format: Format.rating, rating), for: [])
      hardNoteButton.setTitle(note == "" ? "-" : note, for: [])
      hardLabel.text = "\(songButtonKeyPath.hard)"
    }
    if songButtonKeyPath.maximum == 0 {
      for button in maximumButtons {
        button?.isEnabled = false
        button?.setTitle(L10n.none, for: [])
      }
      maximumLabel.text = "-"
    } else {
      guard let recordButtonKeyPath
        = recordInfo.value(forKeyPath: buttonExpansion) as? RecordButtonInfo
        else { return }
      let rank = recordButtonKeyPath.normal?.rank ?? ""
      let rating = recordButtonKeyPath.normal?.rate ?? 0
      let note = recordButtonKeyPath.normal?.note ?? ""
      maximumRankButton.setTitle(rank == "" ? "-" : rank, for: [])
      maximumRatingButton
        .setTitle(rating == 0 ? "-" : String(format: Format.rating, rating), for: [])
      maximumNoteButton.setTitle(note == "" ? "-" : note, for: [])
      maximumLabel.text = "\(songButtonKeyPath.maximum)"
    }
  }
  
  /// Changes properties of button with `recordInfo` and `button`.
  ///
  /// - Parameters:
  ///   - recordInfo: The record information.
  ///   - button:     The specific button.
  func changeButtonProperties(with recordInfo: RecordInfo, inButton button: Button) {
    switch button {
    case .button4:
      buttonButton.setTitle(Button.button5.rawValue.uppercased(), for: [])
      reloadButtonsAndLabels(with: recordInfo, inButton: .button5)
    case .button5:
      buttonButton.setTitle(Button.button6.rawValue.uppercased(), for: [])
      reloadButtonsAndLabels(with: recordInfo, inButton: .button6)
    case .button6:
      buttonButton.setTitle(Button.button8.rawValue.uppercased(), for: [])
      reloadButtonsAndLabels(with: recordInfo, inButton: .button8)
    case .button8:
      buttonButton.setTitle(Button.button4.rawValue.uppercased(), for: [])
      reloadButtonsAndLabels(with: recordInfo, inButton: .button4)
    default:
      break
    }
  }
}

// MARK: - Private Method

private extension RecordView {
  
  /// Updates skill point labels with `recordInfo` and `button`.
  ///
  /// - Parameters:
  ///   - recordInfo: The record information.
  ///   - button:     The specific button.
  func updateSkillPointLabel(with recordInfo: RecordInfo, inButton button: Button) {
    let keyPath = "\(button.expansion ?? "").skillPoint"
    guard let value = recordInfo.value(forKeyPath: keyPath) as? Double else { return }
    skillPointLabel.text = "\(value) \(L10n.point)"
  }
  
  func updateRankingLabel(withTitle title: String, inButton button: Button) {
    let results = RecordInfo.fetch()
      .sorted(byKeyPath: "\(button.expansion ?? "").skillPoint", ascending: false)
    let predicate = NSPredicate(format: "%K == %@ OR %K == %@",
                                #keyPath(RecordInfo.title.english),
                                title,
                                #keyPath(RecordInfo.title.korean),
                                title)
    guard let filtered = results.filter(predicate).first else { return }
    guard let index = results.index(of: filtered) else { return }
    rankingLabel.text = index < 50 ? "#\(index + 1)" : L10n.outOfRank
  }
}
