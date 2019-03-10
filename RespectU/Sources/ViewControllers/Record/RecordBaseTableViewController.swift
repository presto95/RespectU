//
//  RecordBaseTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import RealmSwift

class RecordBaseTableViewController: UITableViewController {
  
  var recordViewController: RecordViewController {
    guard let parent = self.parent as? RecordViewController else { return RecordViewController() }
    return parent
  }
  
  let favoriteButton = UserDefaults.standard.string(forKey: "favoriteButton") ?? "4b"
  
  var tempSongResults: Results<SongInfo>?
  
  var songResults: [SongInfo]?
  
  var recordResults: Results<RecordInfo>?
  
  var recordView: RecordView!
  
  let cellIdentifier = "recordCell"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tempSongResults = SongInfo.fetch()
    recordResults = RecordInfo.fetch()
    tableView.showsVerticalScrollIndicator = false
    tableView.separatorStyle = .none
    tableView.register(UINib(nibName: "RecordCell", bundle: nil),
                       forCellReuseIdentifier: cellIdentifier)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    deselectTableViewIfSelected()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    dismissRecordViewIfExists()
  }
}

extension RecordBaseTableViewController {
  
  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
    guard case let recordCell as RecordCell = cell else { return UITableViewCell() }
    guard let object = songResults?[indexPath.row] else { return UITableViewCell() }
    recordCell.configure(object)
    if let selectedIndexPath = tableView.indexPathForSelectedRow {
      if selectedIndexPath == indexPath {
        recordCell.setColorsInSong(object.series, labels: recordCell.labels)
      } else {
        recordCell.unsetColors(labels: recordCell.labels)
      }
    }
    return cell
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.songResults?.count ?? 0
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let cell = tableView.cellForRow(at: indexPath) as? RecordCell else { return }
    dismissRecordViewIfExists()
    guard let selectedIndexPath = self.tableView.indexPathForSelectedRow else { return }
    guard let songResult = self.songResults?[selectedIndexPath.row] else { return }
    let predicate = NSPredicate(format: "%K == %@",
                                #keyPath(NewRecordInfo.title.english),
                                songResult.title?.english ?? "")
    guard let object = self.recordResults?.filter(predicate).first else { return }
    cell.setColorsInSong(object.series, labels: cell.labels)
    self.recordView = UIView.instantiateFromXib(xibName: "RecordView") as? RecordView
    self.recordView.delegate = self
    self.recordView.translatesAutoresizingMaskIntoConstraints = false
    recordViewController.view.addSubview(recordView)
    let leadingConstraint = recordView.leadingAnchor
      .constraint(equalTo: recordViewController.view.leadingAnchor, constant: 8)
    let trailingConstraint = recordView.trailingAnchor
      .constraint(equalTo: recordViewController.view.trailingAnchor, constant: -8)
    let heightConstraint = recordView.heightAnchor
      .constraint(equalToConstant: 200)
    let centerXConstraint = recordView.centerXAnchor
      .constraint(equalTo: recordViewController.view.centerXAnchor)
    let bottomConstraint: NSLayoutConstraint
    if #available(iOS 11.0, *) {
      bottomConstraint = recordView.safeAreaLayoutGuide.bottomAnchor
        .constraint(equalTo: recordViewController.view.safeAreaLayoutGuide.bottomAnchor,
                    constant: -20)
    } else {
      bottomConstraint = recordView.bottomAnchor
        .constraint(equalTo: recordViewController.view.bottomAnchor, constant: -20)
    }
    NSLayoutConstraint.activate([
      leadingConstraint,
      trailingConstraint,
      heightConstraint,
      centerXConstraint,
      bottomConstraint
      ])
    self.recordView.updateRankingAndSkillPointLabel(object, button: favoriteButton)
    self.recordView.reloadButtonsAndLabels(object, button: favoriteButton)
    recordViewController.scrollViewBottomConstraint.constant += 210
    recordViewController.view.layoutIfNeeded()
    tableView.scrollToNearestSelectedRow(at: .middle, animated: true)
  }
  
  override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    guard let cell = tableView.cellForRow(at: indexPath) as? RecordCell else { return }
    cell.unsetColors(labels: cell.labels)
  }
  
  override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
    guard let cell = tableView.cellForRow(at: indexPath) as? RecordCell else { return }
    guard let object = self.songResults?[indexPath.row] else { return }
    cell.setColorsInSong(object.series, labels: cell.labels)
    
  }
  
  override func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
    guard let cell = tableView.cellForRow(at: indexPath) as? RecordCell else { return }
    cell.unsetColors(labels: cell.labels)
  }
}

extension RecordBaseTableViewController: RecordViewDelegate {
  
  func didTouchUpTypeButton(_ sender: UIButton) {
    let button = (sender.title(for: .normal) ?? Button.button4).lowercased()
    guard let selectedIndexPath = self.tableView.indexPathForSelectedRow else { return }
    guard let songResult = songResults?[selectedIndexPath.row] else { return }
    let predicate = NSPredicate(format: "%K == %@",
                                #keyPath(NewRecordInfo.title.english),
                                songResult.title?.english ?? "")
    guard let object = recordResults?.filter(predicate).first else { return }
    recordView.changeButtonProperties(object, button: button)
  }
  
  func presentRankAlert(difficulty: String, button: String) {
    guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
    guard let songResult = songResults?[selectedIndexPath.row] else { return }
    let predicate = NSPredicate(format: "%K == %@",
                                #keyPath(NewRecordInfo.title.english),
                                songResult.title?.english ?? "")
    guard let object = self.recordResults?.filter(predicate).first else { return }
    UIAlertController
      .alert(title: "Rank".localized, message: "Select the rank.".localized)
      .action(title: "-") { [weak self] _ in
        self?.setRank(object, rank: Rank.none, difficulty: difficulty, button: button)
        self?.recordView.reloadButtonsAndLabels(object, button: button)
      }
      .action(title: Rank.s) { [weak self] _ in
        self?.setRank(object, rank: Rank.s, difficulty: difficulty, button: button)
        self?.recordView.reloadButtonsAndLabels(object, button: button)
      }
      .action(title: Rank.a) { [weak self] _ in
        self?.setRank(object, rank: Rank.a, difficulty: difficulty, button: button)
        self?.recordView.reloadButtonsAndLabels(object, button: button)
      }
      .action(title: Rank.b) { [weak self] _ in
        self?.setRank(object, rank: Rank.b, difficulty: difficulty, button: button)
        self?.recordView.reloadButtonsAndLabels(object, button: button)
      }
      .action(title: Rank.c) { [weak self] _ in
        self?.setRank(object, rank: Rank.c, difficulty: difficulty, button: button)
        self?.recordView.reloadButtonsAndLabels(object, button: button)
      }
      .action(.cancel, title: "Cancel".localized)
      .present(to: self)
  }
  
  func presentRateAlert(difficulty: String, button: String) {
    guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
    guard let songResult = songResults?[selectedIndexPath.row] else { return }
    let predicate = NSPredicate(format: "%K == %@",
                                #keyPath(NewRecordInfo.title.english),
                                songResult.title?.english ?? "")
    guard let object = recordResults?.filter(predicate).first else { return }
    let message = """
    Enter the rate.\nTo reset the value, do not enter any values.
    """
    let alert = UIAlertController
      .alert(title: "Rate".localized, message: message.localized)
    alert.textField { (textField) in
      textField.keyboardType = .decimalPad
      textField.placeholder = "Rate".localized
      }
      .action(title: "OK".localized) { [weak self] _ in
        let input = alert.textFields?.first?.text ?? ""
        if input.isEmpty {
          self?.setRate(object, rate: 0, difficulty: difficulty, button: button)
        } else {
          guard let value = Double(input) else { return }
          let rate = value >= 100 ? 100 : value
          self?.setRate(object, rate: rate, difficulty: difficulty, button: button)
          switch rate {
          case 98...100:
            self?.setRank(object, rank: Rank.s, difficulty: difficulty, button: button)
          case 95..<98:
            self?.setRank(object, rank: Rank.a, difficulty: difficulty, button: button)
          case 90..<95:
            self?.setRank(object, rank: Rank.b, difficulty: difficulty, button: button)
          case ..<90:
            self?.setRank(object, rank: Rank.c, difficulty: difficulty, button: button)
          default:
            break
          }
        }
        self?.recordView.reloadButtonsAndLabels(object, button: button)
        guard let buttonExpansion = button.buttonExpansion else { return }
        guard let note = object.value(forKeyPath: "\(buttonExpansion).\(difficulty).note") as? String else { return }
        if note != Note.maxCombo {
          self?.presentNoteAlert(difficulty: difficulty, button: button)
        }
      }
      .action(.cancel, title: "Cancel".localized)
      .present(to: self)
  }
  
  func presentNoteAlert(difficulty: String, button: String) {
    guard let selectedIndexPath = self.tableView.indexPathForSelectedRow else { return }
    guard let songResult = self.songResults?[selectedIndexPath.row] else { return }
    let predicate = NSPredicate(format: "%K == %@", #keyPath(NewRecordInfo.title.english), songResult.title?.english ?? "")
    guard let object = self.recordResults?.filter(predicate).first else { return }
    UIAlertController
      .alert(title: "Note".localized, message: "Select the note.".localized)
      .action(title: "-") { [weak self] _ in
        self?.setNote(object, note: Note.none, difficulty: difficulty, button: button)
        self?.recordView.reloadButtonsAndLabels(object, button: button)
      }
      .action(title: Note.maxCombo.noteExpansion) { [weak self] _ in
        self?.setNote(object, note: Note.maxCombo, difficulty: difficulty, button: button)
        self?.recordView.reloadButtonsAndLabels(object, button: button)
      }
      .action(title: Note.perfectPlay.noteExpansion) { [weak self] _ in
        self?.setRank(object, rank: Rank.s, difficulty: difficulty, button: button)
        self?.setRate(object, rate: 100, difficulty: difficulty, button: button)
        self?.setNote(object, note: Note.perfectPlay, difficulty: difficulty, button: button)
        self?.recordView.reloadButtonsAndLabels(object, button: button)
      }
      .action(.cancel, title: "Cancel".localized)
      .present(to: self)
  }
  
  func didTouchUpCancelButton() {
    dismissRecordViewIfExists()
    deselectTableViewIfSelected()
  }
}

extension RecordBaseTableViewController {
  
  private func setRank(_ object: RecordInfo, rank: String, difficulty: String, button: String) {
    guard let buttonExpansion = button.buttonExpansion else { return }
    let keyPath = "\(buttonExpansion).\(difficulty).rank"
    RecordInfo.update(object, with: [keyPath: rank])
  }
  
  private func setRate(_ object: RecordInfo, rate: Double, difficulty: String, button: String) {
    guard let buttonExpansion = button.buttonExpansion else { return }
    let keyPath = "\(buttonExpansion).\(difficulty).rate"
    RecordInfo.update(object, with: [keyPath: rate])
    setSkillPoint(object, button: button)
    recordView.updateRankingAndSkillPointLabel(object, button: button)
  }
  
  private func setNote(_ object: RecordInfo, note: String, difficulty: String, button: String) {
    guard let buttonExpansion = button.buttonExpansion else { return }
    let keyPath = "\(buttonExpansion).\(difficulty).note"
    RecordInfo.update(object, with: [keyPath: note])
    setSkillPoint(object, button: button)
    recordView.updateRankingAndSkillPointLabel(object, button: button)
  }
  
  private func setSkillPoint(_ object: RecordInfo, button: String) {
    guard let buttonExpansion = button.buttonExpansion else { return }
    guard let recordButtonKeyPath
      = object.value(forKeyPath: buttonExpansion) as? NewRecordButtonInfo else { return }
    let predicate = NSPredicate(format: "%K == %@",
                                #keyPath(SongInfo.title.english),
                                object.title?.english ?? "")
    guard let songResult = tempSongResults?.filter(predicate).first else { return }
    guard let songButtonKeyPath = songResult.value(forKeyPath: buttonExpansion) as? SongButtonInfo
      else { return }
    let normal = Skill.skillPoint(difficulty: songButtonKeyPath.normal,
                                  rate: recordButtonKeyPath.normal?.rate,
                                  note: recordButtonKeyPath.normal?.note)
    let hard = Skill.skillPoint(difficulty: songButtonKeyPath.hard,
                                rate: recordButtonKeyPath.hard?.rate,
                                note: recordButtonKeyPath.hard?.note)
    let maximum = Skill.skillPoint(difficulty: songButtonKeyPath.maximum,
                                   rate: recordButtonKeyPath.maximum?.rate,
                                   note: recordButtonKeyPath.maximum?.note)
    guard let max = [normal, hard, maximum].sorted().last else { return }
    RecordInfo.update(object, with: ["\(buttonExpansion).skillPoint": max])
    switch max {
    case normal:
      RecordInfo.update(object, with: [
        "\(buttonExpansion).skillPointDifficulty": Difficulty.normal,
        "\(buttonExpansion).skillPointRate": recordButtonKeyPath.normal?.rate ?? 0,
        "\(buttonExpansion).skillPointNote": recordButtonKeyPath.normal?.note ?? ""
        ])
    case hard:
      RecordInfo.update(object, with: [
        "\(buttonExpansion).skillPointDifficulty": Difficulty.hard,
        "\(buttonExpansion).skillPointRate": recordButtonKeyPath.hard?.rate ?? 0,
        "\(buttonExpansion).skillPointNote": recordButtonKeyPath.hard?.note ?? ""
        ])
    case maximum:
      RecordInfo.update(object, with: [
        "\(buttonExpansion).skillPointDifficulty": Difficulty.maximum,
        "\(buttonExpansion).skillPointRate": recordButtonKeyPath.maximum?.rate ?? 0,
        "\(buttonExpansion).skillPointNote": recordButtonKeyPath.maximum?.note ?? ""
        ])
    default:
      break
    }
  }
}

extension RecordBaseTableViewController {
  
  private func dismissRecordViewIfExists() {
    let lastSubview = recordViewController.view.subviews.last
    if lastSubview is RecordView {
      lastSubview?.removeFromSuperview()
      recordViewController.scrollViewBottomConstraint.constant -= 210
    }
  }
  
  private func deselectTableViewIfSelected() {
    
    if let selectedIndexPath = self.tableView.indexPathForSelectedRow {
      guard let cell = tableView.cellForRow(at: selectedIndexPath) as? RecordCell else { return }
      tableView.deselectRow(at: selectedIndexPath, animated: true)
      cell.unsetColors(labels: cell.labels)
    }
  }
}
