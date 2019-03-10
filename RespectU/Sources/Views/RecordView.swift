//
//  RecordView.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import RealmSwift

protocol RecordViewDelegate: class {
  func didTouchUpTypeButton(_ sender: UIButton)
  func presentRankAlert(difficulty: String, button: String)
  func presentRateAlert(difficulty: String, button: String)
  func presentNoteAlert(difficulty: String, button: String)
  func didTouchUpCancelButton()
}

final class RecordView: UIView {
  
  weak var delegate: RecordViewDelegate?
  
  @IBOutlet weak var titleLabel: UILabel!
  
  @IBOutlet weak var skillPointLabel: UILabel!
  
  @IBOutlet weak var buttonButton: UIButton!
  
  @IBOutlet weak var normalRankButton: UIButton!
  
  @IBOutlet weak var normalRateButton: UIButton!
  
  @IBOutlet weak var normalNoteButton: UIButton!
  
  @IBOutlet weak var hardRankButton: UIButton!
  
  @IBOutlet weak var hardRateButton: UIButton!
  
  @IBOutlet weak var hardNoteButton: UIButton!
  
  @IBOutlet weak var maximumRankButton: UIButton!
  
  @IBOutlet weak var maximumRateButton: UIButton!
  
  @IBOutlet weak var maximumNoteButton: UIButton!
  
  @IBOutlet weak var cancelButton: UIButton!
  
  @IBOutlet weak var normalLabel: UILabel!
  
  @IBOutlet weak var hardLabel: UILabel!
  
  @IBOutlet weak var maximumLabel: UILabel!
  
  @IBOutlet weak var rankingLabel: UILabel!
  
  var levelLabels: [UILabel] {
    return [normalLabel, hardLabel, maximumLabel]
  }
  
  var normalButtons: [UIButton] {
    return [normalRankButton, normalRateButton, normalNoteButton]
  }
  
  var hardButtons: [UIButton] {
    return [hardRankButton, hardRateButton, hardNoteButton]
  }
  
  var maximumButtons: [UIButton] {
    return [maximumRankButton, maximumRateButton, maximumNoteButton]
  }
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.layer.borderWidth = 1
    self.layer.cornerRadius = 15
    self.layer.borderColor = UIColor.lightGray.cgColor
    self.cancelButton.setTitle("Cancel".localized, for: .normal)
    self.cancelButton.addTarget(self, action: #selector(cancelButtonDidTap(_:)), for: .touchUpInside)
  }
  
  @IBAction func didTouchUpOtherButtons(_ sender: UIButton) {
    let button = (buttonButton.title(for: .normal) ?? "4b").lowercased()
    switch sender.tag {
    case 0:
      delegate?.presentRankAlert(difficulty: Difficulty.normal, button: button)
    case 1:
      delegate?.presentRateAlert(difficulty: Difficulty.normal, button: button)
    case 2:
      delegate?.presentNoteAlert(difficulty: Difficulty.normal, button: button)
    case 3:
      delegate?.presentRankAlert(difficulty: Difficulty.hard, button: button)
    case 4:
      delegate?.presentRateAlert(difficulty: Difficulty.hard, button: button)
    case 5:
      delegate?.presentNoteAlert(difficulty: Difficulty.hard, button: button)
    case 6:
      delegate?.presentRankAlert(difficulty: Difficulty.maximum, button: button)
    case 7:
      delegate?.presentRateAlert(difficulty: Difficulty.maximum, button: button)
    case 8:
      delegate?.presentNoteAlert(difficulty: Difficulty.maximum, button: button)
    default:
      break
    }
  }
  
  @IBAction func didTouchUpTypeButton(_ sender: UIButton) {
    delegate?.didTouchUpTypeButton(sender)
  }
  
  @IBAction func didTouchUpCancelButton(_ sender: UIButton) {
    delegate?.didTouchUpCancelButton()
  }
}

extension RecordView {
  
  func changeButtonProperties(_ object: RecordInfo, button: String) {
    switch button {
    case Button.button4:
      self.buttonButton.setTitle(Button.button5.uppercased(), for: [])
      reloadButtonsAndLabels(object, button: Button.button5)
    case Button.button5:
      self.buttonButton.setTitle(Button.button6.uppercased(), for: [])
      reloadButtonsAndLabels(object, button: Button.button6)
    case Button.button6:
      self.buttonButton.setTitle(Button.button8.uppercased(), for: [])
      reloadButtonsAndLabels(object, button: Button.button8)
    case Button.button8:
      self.buttonButton.setTitle(Button.button4.uppercased(), for: [])
      reloadButtonsAndLabels(object, button: Button.button4)
    default:
      break
    }
  }
  
  func updateRankingAndSkillPointLabel(_ object: RecordInfo, button: String) {
    updateSkillPointLabel(object, button: button)
    updateRankingLabel(title: object.localizedTitle, button: button)
  }
  
  func reloadButtonsAndLabels(_ object: RecordInfo, button: String) {
    let predicate = NSPredicate(format: "%K == %@", #keyPath(SongInfo.title.english), object.title?.english ?? "")
    guard let songResult = SongInfo.fetch().filter(predicate).first else { return }
    self.buttonButton.setTitle(button.uppercased(), for: [])
    self.titleLabel.text = object.localizedTitle
    let normalButtons = [normalRankButton, normalRateButton, normalNoteButton]
    let hardButtons = [hardRankButton, hardRateButton, hardNoteButton]
    let maximumButtons = [maximumRankButton, maximumRateButton, maximumNoteButton]
    for index in 0..<3 {
      normalButtons[index]?.isEnabled = true
      hardButtons[index]?.isEnabled = true
      maximumButtons[index]?.isEnabled = true
    }
    guard let buttonExpansion = button.buttonExpansion else { return }
    updateRankingLabel(title: object.localizedTitle, button: button)
    self.updateSkillPointLabel(object, button: button)
    guard let songButtonKeyPath = songResult.value(forKeyPath: buttonExpansion) as? SongButtonInfo else { return }
    if songButtonKeyPath.normal == 0 {
      for button in normalButtons {
        button?.isEnabled = false
        button?.setTitle("None".localized, for: [])
      }
      normalLabel.text = "-"
    } else {
      guard let recordButtonKeyPath = object.value(forKeyPath: buttonExpansion) as? NewRecordButtonInfo else { return }
      let rank = recordButtonKeyPath.normal?.rank ?? ""
      let rate = recordButtonKeyPath.normal?.rate ?? 0
      let note = recordButtonKeyPath.normal?.note ?? ""
      normalRankButton.setTitle(rank == "" ? "-" : rank, for: [])
      normalRateButton.setTitle(rate == 0 ? "-" : String(format: "%05.2f%%", rate), for: [])
      normalNoteButton.setTitle(note == "" ? "-" : note, for: [])
      normalLabel.text = "\(songButtonKeyPath.normal)"
    }
    if songButtonKeyPath.hard == 0 {
      for button in hardButtons {
        button?.isEnabled = false
        button?.setTitle("None".localized, for: [])
      }
      hardLabel.text = "-"
    } else {
      guard let recordButtonKeyPath = object.value(forKeyPath: buttonExpansion) as? NewRecordButtonInfo else { return }
      let rank = recordButtonKeyPath.hard?.rank ?? ""
      let rate = recordButtonKeyPath.hard?.rate ?? 0
      let note = recordButtonKeyPath.hard?.note ?? ""
      hardRankButton.setTitle(rank == "" ? "-" : rank, for: [])
      hardRateButton.setTitle(rate == 0 ? "-" : String(format: "%05.2f%%", rate), for: [])
      hardNoteButton.setTitle(note == "" ? "-" : note, for: [])
      hardLabel.text = "\(songButtonKeyPath.hard)"
    }
    if songButtonKeyPath.maximum == 0 {
      for button in maximumButtons {
        button?.isEnabled = false
        button?.setTitle("None".localized, for: [])
      }
      maximumLabel.text = "-"
    } else {
      guard let recordButtonKeyPath = object.value(forKeyPath: buttonExpansion) as? NewRecordButtonInfo else { return }
      let rank = recordButtonKeyPath.maximum?.rank ?? ""
      let rate = recordButtonKeyPath.maximum?.rate ?? 0
      let note = recordButtonKeyPath.maximum?.note ?? ""
      maximumRankButton.setTitle(rank == "" ? "-" : rank, for: [])
      maximumRateButton.setTitle(rate == 0 ? "-" : String(format: "%05.2f%%", rate), for: [])
      maximumNoteButton.setTitle(note == "" ? "-" : note, for: [])
      maximumLabel.text = "\(songButtonKeyPath.maximum)"
    }
  }
}

extension RecordView {
  
  private func updateSkillPointLabel(_ object: RecordInfo, button: String) {
    guard let buttonExpansion = button.buttonExpansion else { return }
    let keyPath = "\(buttonExpansion).skillPoint"
    guard let value = object.value(forKeyPath: keyPath) as? Double else { return }
    self.skillPointLabel.text = "\(value) " + "Point".localized
  }
  
  private func updateRankingLabel(title: String, button: String) {
    guard let buttonExpansion = button.buttonExpansion else { return }
    let results = RecordInfo.fetch().sorted(byKeyPath: "\(buttonExpansion).skillPoint", ascending: false)
    let predicate = NSPredicate(format: "%K == %@ OR %K == %@", #keyPath(NewRecordInfo.title.english), title, #keyPath(NewRecordInfo.title.korean), title)
    guard let filtered = results.filter(predicate).first else { return }
    guard let index = results.index(of: filtered) else { return }
    if index < 50 {
      self.rankingLabel.text = "#\(index + 1)"
    } else {
      self.rankingLabel.text = "Out of Rank".localized
    }
  }
}
