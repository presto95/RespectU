//
//  RecordBaseTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import RealmSwift

/// The record base table view controller.
class RecordBaseTableViewController: UITableViewController {
  
  private var recordViewController: RecordViewController {
    guard let parent = parent as? RecordViewController else { return RecordViewController() }
    return parent
  }
  
  var tempSongResults: Results<SongInfo>?
  
  var songResults: [SongInfo]?
  
  private var recordResults: Results<RecordInfo>?
  
  private var recordView: RecordView!
  
  private let cellIdentifier = "recordCell"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    deselectTableViewIfSelected()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    dismissRecordViewIfExists()
  }
  
  private func configure() {
    tempSongResults = SongInfo.fetch()
    recordResults = RecordInfo.fetch()
    tableView.showsVerticalScrollIndicator = false
    tableView.separatorStyle = .none
    tableView.register(UINib(nibName: RecordCell.name, bundle: nil),
                       forCellReuseIdentifier: cellIdentifier)
  }
}

extension RecordBaseTableViewController {
  
  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
    guard case let recordCell as RecordCell = cell else { return UITableViewCell() }
    guard let object = songResults?[indexPath.row] else { return UITableViewCell() }
    recordCell.configure(with: object)
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
                                #keyPath(RecordInfo.title.english),
                                songResult.title?.english ?? "")
    guard let object = recordResults?.filter(predicate).first else { return }
    cell.setColorsInSong(object.series, labels: cell.labels)
    recordView = UIView.instantiateFromXib(xibName: RecordView.name) as? RecordView
    recordView.delegate = self
    recordView.translatesAutoresizingMaskIntoConstraints = false
    recordViewController.view.addSubview(recordView)
    let leadingConstraint = recordView.leadingAnchor
      .constraint(equalTo: recordViewController.view.leadingAnchor, constant: 8)
    let trailingConstraint = recordView.trailingAnchor
      .constraint(equalTo: recordViewController.view.trailingAnchor, constant: -8)
    let heightConstraint = recordView.heightAnchor
      .constraint(equalToConstant: 200)
    let centerXConstraint = recordView.centerXAnchor
      .constraint(equalTo: recordViewController.view.centerXAnchor)
    let bottomConstraint = recordView.safeAreaLayoutGuide.bottomAnchor
      .constraint(equalTo: recordViewController.view.safeAreaLayoutGuide.bottomAnchor,
                  constant: -20)
    NSLayoutConstraint.activate([
      leadingConstraint,
      trailingConstraint,
      heightConstraint,
      centerXConstraint,
      bottomConstraint
      ])
    recordView.updateRankingAndSkillPointLabel(with: object, inButton: Persistence.favoriteButton)
    recordView.reloadButtonsAndLabels(with: object, inButton: Persistence.favoriteButton)
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
    guard let object = songResults?[indexPath.row] else { return }
    cell.setColorsInSong(object.series, labels: cell.labels)
    
  }
  
  override func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
    guard let cell = tableView.cellForRow(at: indexPath) as? RecordCell else { return }
    cell.unsetColors(labels: cell.labels)
  }
}

// MARK: - Conforming RecordViewDelegate

extension RecordBaseTableViewController: RecordViewDelegate {
  
  func recordView(_ view: RecordView, didTapTypeButton button: UIButton) {
    let button = (sender.title(for: .normal) ?? Button.button4).lowercased()
    guard let selectedIndexPath = self.tableView.indexPathForSelectedRow else { return }
    guard let songResult = songResults?[selectedIndexPath.row] else { return }
    let predicate = NSPredicate(format: "%K == %@",
                                #keyPath(RecordInfo.title.english),
                                songResult.title?.english ?? "")
    guard let object = recordResults?.filter(predicate).first else { return }
    recordView.changeButtonProperties(object, button: button)
  }
  
  func recordView(_ view: RecordView, didTapCancelButton button: UIButton) {
    dismissRecordViewIfExists()
    deselectTableViewIfSelected()
    
  }
  
  func recordView(_ view: RecordView,
                  didTapRankRecordButton button: UIButton,
                  inDifficulty difficulty: Difficulty,
                  inCurrentButton currentButton: Button) {
    guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
    guard let songResult = songResults?[selectedIndexPath.row] else { return }
    let predicate = NSPredicate(format: "%K == %@",
                                #keyPath(RecordInfo.title.english),
                                songResult.title?.english ?? "")
    guard let object = recordResults?.filter(predicate).first else { return }
    UIAlertController
      .alert(title: L10n.rank, message: L10n.selectTheRank)
      .action(title: "-") { [weak self] _ in
        self?.setRank(object, rank: Rank.none, difficulty: difficulty, button: button)
        self?.recordView.reloadButtonsAndLabels(object, button: button)
      }
      .action(title: Rank.s.rawValue.uppercased()) { [weak self] _ in
        self?.setRank(object, rank: Rank.s, difficulty: difficulty, button: button)
        self?.recordView.reloadButtonsAndLabels(object, button: button)
      }
      .action(title: Rank.a.rawValue.uppercased()) { [weak self] _ in
        self?.setRank(object, rank: Rank.a, difficulty: difficulty, button: button)
        self?.recordView.reloadButtonsAndLabels(object, button: button)
      }
      .action(title: Rank.b.rawValue.uppercased()) { [weak self] _ in
        self?.setRank(object, rank: Rank.b, difficulty: difficulty, button: button)
        self?.recordView.reloadButtonsAndLabels(object, button: button)
      }
      .action(title: Rank.c.rawValue.uppercased()) { [weak self] _ in
        self?.setRank(object, rank: Rank.c, difficulty: difficulty, button: button)
        self?.recordView.reloadButtonsAndLabels(object, button: button)
      }
      .action(title: L10n.cancel, style: .cancel)
      .present(to: self)
  }
  
  func recordView(_ view: RecordView,
                  didTapRatingRecordButton button: UIButton,
                  inDifficulty difficulty: Difficulty,
                  inCurrentButton currentButton: Button) {
    guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
    guard let songResult = songResults?[selectedIndexPath.row] else { return }
    let predicate = NSPredicate(format: "%K == %@",
                                #keyPath(RecordInfo.title.english),
                                songResult.title?.english ?? "")
    guard let object = recordResults?.filter(predicate).first else { return }
    let message = """
    Enter the rate.\nTo reset the value, do not enter any values.
    """
    let alert = UIAlertController
      .alert(title: L10n.rating, message: message.localized)
    alert.textField {
      $0.keyboardType = .decimalPad
      $0.placeholder = L10n.rating
      }
      .action(title: L10n.ok) { [weak self] _ in
        let input = alert.textFields?.first?.text ?? ""
        if input.isEmpty {
          self?.setRating(0, with: object, inDifficulty: difficulty, inButton: currentButton)
        } else {
          guard let value = Double(input) else { return }
          let rate = value >= 100 ? 100 : value
          self?.setRating(rate, with: object, inDifficulty: difficulty, inButton: currentButton)
          switch rate {
          case 98...100:
            self?.setRank(.s, with: object, inDifficulty: difficulty, inButton: currentButton)
          case 95..<98:
            self?.setRank(.a, with: object, inDifficulty: difficulty, inButton: currentButton)
          case 90..<95:
            self?.setRank(.b, with: object, inDifficulty: difficulty, inButton: currentButton)
          case ..<90:
            self?.setRank(.c, with: object, inDifficulty: difficulty, inButton: currentButton)
          default:
            break
          }
        }
        self?.recordView.reloadButtonsAndLabels(with: object, inButton: currentButton)
        guard let buttonExpansion = button.buttonExpansion else { return }
        guard let note = object.value(forKeyPath: "\(buttonExpansion).\(difficulty).note") as? String else { return }
        if note != Note.maxCombo {
          self?.presentNoteAlert(difficulty: difficulty, button: button)
        }
      }
      .action(title: L10n.cancel, style: .cancel)
      .present(to: self)
  }
  
  func recordView(_ view: RecordView,
                  didTapNoteRecordButton button: UIButton,
                  inDifficulty difficulty: Difficulty,
                  inCurrentButton currentButton: Button) {
    guard let selectedIndexPath = self.tableView.indexPathForSelectedRow else { return }
    guard let songResult = self.songResults?[selectedIndexPath.row] else { return }
    let predicate = NSPredicate(format: "%K == %@",
                                #keyPath(RecordInfo.title.english),
                                songResult.title?.english ?? "")
    guard let object = self.recordResults?.filter(predicate).first else { return }
    UIAlertController
      .alert(title: L10n.note, message: L10n.selectTheNote)
      .action(title: "-") { [weak self] _ in
        self?.setNote(object, note: Note.none, difficulty: difficulty, button: button)
        self?.recordView.reloadButtonsAndLabels(object, button: button)
      }
      .action(title: Note.maxCombo.expansion) { [weak self] _ in
        self?.setNote(object, note: Note.maxCombo, difficulty: difficulty, button: button)
        self?.recordView.reloadButtonsAndLabels(object, button: button)
      }
      .action(title: Note.perfectPlay.expansion) { [weak self] _ in
        self?.setRank(object, rank: Rank.s, difficulty: difficulty, button: button)
        self?.setRate(object, rate: 100, difficulty: difficulty, button: button)
        self?.setNote(object, note: Note.perfectPlay, difficulty: difficulty, button: button)
        self?.recordView.reloadButtonsAndLabels(object, button: button)
      }
      .action(title: L10n.cancel, style: .cancel)
      .present(to: self)
  }
}

// MARK: - Private Method

private extension RecordBaseTableViewController {
  
  func setRank(_ rank: Rank,
               with recordInfo: RecordInfo,
               inDifficulty difficulty: Difficulty,
               inButton button: Button) {
    let keyPath = "\(button.expansion ?? "").\(difficulty.rawValue).rank"
    RecordInfo.update(recordInfo, with: [keyPath: rank.rawValue.uppercased()])
  }
  
  func setRating(_ rating: Double,
                 with recordInfo: RecordInfo,
                 inDifficulty difficulty: Difficulty,
                 inButton button: Button) {
    let keyPath = "\(button.expansion ?? "").\(difficulty.rawValue).rate"
    RecordInfo.update(recordInfo, with: [keyPath: rating])
    updateSkillPoint(with: recordInfo, inButton: button)
    recordView.updateRankingAndSkillPointLabel(with: recordInfo, inButton: button)
  }
  
  func setNote(_ note: Note,
               with recordInfo: RecordInfo,
               inDifficulty difficulty: Difficulty,
               inButton button: Button) {
    let keyPath = "\(button.expansion ?? "").\(difficulty.rawValue).note"
    RecordInfo.update(recordInfo, with: [keyPath: note.rawValue])
    updateSkillPoint(with: recordInfo, inButton: button)
    recordView.updateRankingAndSkillPointLabel(with: recordInfo, inButton: button)
  }
  
  func updateSkillPoint(with recordInfo: RecordInfo, inButton button: Button) {
    guard let recordButtonKeyPath
      = recordInfo.value(forKeyPath: button.expansion ?? "") as? RecordButtonInfo
      else { return }
    let predicate = NSPredicate(format: "%K == %@",
                                #keyPath(SongInfo.title.english),
                                recordInfo.title?.english ?? "")
    guard let songResult = tempSongResults?.filter(predicate).first else { return }
    guard let songButtonKeyPath
      = songResult.value(forKeyPath: button.expansion ?? "") as? SongButtonInfo
      else { return }
    let buttonExpansion = button.expansion ?? ""
    let normalSkillPoint = Utils
      .skillPoint(difficulty: songButtonKeyPath.normal,
                  rate: recordButtonKeyPath.normal?.rate,
                  note: Note(rawValue: recordButtonKeyPath.normal?.note ?? "") ?? .none)
    let hardSkillPoint = Utils
      .skillPoint(difficulty: songButtonKeyPath.hard,
                  rate: recordButtonKeyPath.hard?.rate,
                  note: Note(rawValue: recordButtonKeyPath.hard?.note ?? "") ?? .none)
    let maximumSkillPoint = Utils
      .skillPoint(difficulty: songButtonKeyPath.maximum,
                  rate: recordButtonKeyPath.maximum?.rate,
                  note: Note(rawValue: recordButtonKeyPath.maximum?.note ?? "") ?? .none)
    guard let skillPoint = [normalSkillPoint, hardSkillPoint, maximumSkillPoint].sorted().last
      else { return }
    RecordInfo.update(recordInfo, with: ["\(buttonExpansion).skillPoint": skillPoint])
    switch skillPoint {
    case normalSkillPoint:
      RecordInfo.update(recordInfo, with: [
        "\(buttonExpansion).skillPointDifficulty": Difficulty.normal.rawValue,
        "\(buttonExpansion).skillPointRate": recordButtonKeyPath.normal?.rate ?? 0,
        "\(buttonExpansion).skillPointNote": recordButtonKeyPath.normal?.note ?? ""
        ])
    case hardSkillPoint:
      RecordInfo.update(recordInfo, with: [
        "\(buttonExpansion).skillPointDifficulty": Difficulty.hard.rawValue,
        "\(buttonExpansion).skillPointRate": recordButtonKeyPath.hard?.rate ?? 0,
        "\(buttonExpansion).skillPointNote": recordButtonKeyPath.hard?.note ?? ""
        ])
    case maximumSkillPoint:
      RecordInfo.update(recordInfo, with: [
        "\(buttonExpansion).skillPointDifficulty": Difficulty.maximum.rawValue,
        "\(buttonExpansion).skillPointRate": recordButtonKeyPath.maximum?.rate ?? 0,
        "\(buttonExpansion).skillPointNote": recordButtonKeyPath.maximum?.note ?? ""
        ])
    default:
      break
    }
  }
  
  func dismissRecordViewIfExists() {
    if let lastSubview = recordViewController.view.subviews.last as? RecordView {
      lastSubview.removeFromSuperview()
      recordViewController.scrollViewBottomConstraint.constant -= 210
    }
  }
  
  func deselectTableViewIfSelected() {
    if let selectedIndexPath = self.tableView.indexPathForSelectedRow {
      guard let cell = tableView.cellForRow(at: selectedIndexPath) as? RecordCell else { return }
      tableView.deselectRow(at: selectedIndexPath, animated: true)
      cell.unsetColors(labels: cell.labels)
    }
  }
}
