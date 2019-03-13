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
  
  /// The record view controller which the parent of this view controller.
  private var recordViewController: RecordViewController {
    guard let parent = parent as? RecordViewController else { return RecordViewController() }
    return parent
  }
  
  /// The fetched temperature song results.
  var tempSongResults: Results<SongInfo>?
  
  /// The processed song results.
  var songResults: [SongInfo]?
  
  /// The fetched record results.
  private var recordResults: Results<RecordInfo>?
  
  /// The record view.
  private var recordView: RecordView!
  
  /// The cell identifier.
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
  
  /// Configures initial settings.
  private func configure() {
    tempSongResults = SongInfo.fetch()
    recordResults = RecordInfo.fetch()
    tableView.showsVerticalScrollIndicator = false
    tableView.separatorStyle = .none
    tableView.register(UINib(nibName: RecordCell.name, bundle: nil),
                       forCellReuseIdentifier: cellIdentifier)
  }
}

// MARK: - UITableView Configuration

extension RecordBaseTableViewController {
  
  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
    guard case let recordCell as RecordCell = cell else { return UITableViewCell() }
    guard let object = songResults?[indexPath.row] else { return UITableViewCell() }
    recordCell.configure(with: object)
    if let selectedIndexPath = tableView.indexPathForSelectedRow {
      if selectedIndexPath == indexPath {
        recordCell.colorizeSubviews(in: object.seriesEnum ?? .respect)
      } else {
        recordCell.decolorizeSubviews()
      }
    }
    return cell
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return songResults?.count ?? 0
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let cell = tableView.cellForRow(at: indexPath) as? RecordCell else { return }
    dismissRecordViewIfExists()
    guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
    guard let songResult = songResults?[selectedIndexPath.row] else { return }
    let predicate = NSPredicate(format: "%K == %@",
                                #keyPath(RecordInfo.title.english),
                                songResult.title?.english ?? "")
    guard let object = recordResults?.filter(predicate).first else { return }
    cell.colorizeSubviews(in: object.seriesEnum ?? .respect)
    recordView = UIView.instantiateFromXIB(xibName: RecordView.name) as? RecordView
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
    cell.decolorizeSubviews()
  }
  
  override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
    guard let cell = tableView.cellForRow(at: indexPath) as? RecordCell else { return }
    guard let object = songResults?[indexPath.row] else { return }
    cell.colorizeSubviews(in: object.seriesEnum ?? .respect)
    
  }
  
  override func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
    guard let cell = tableView.cellForRow(at: indexPath) as? RecordCell else { return }
    cell.decolorizeSubviews()
  }
}

// MARK: - Conforming RecordViewDelegate

extension RecordBaseTableViewController: RecordViewDelegate {
  
  func recordView(_ view: RecordView, didTapTypeButton button: UIButton) {
    let buttonTitle = button.title(for: .normal)?.lowercased() ?? ""
    let button = Button(rawValue: buttonTitle) ?? .button4
    guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
    guard let songResult = songResults?[selectedIndexPath.row] else { return }
    let predicate = NSPredicate(format: "%K == %@",
                                #keyPath(RecordInfo.title.english),
                                songResult.title?.english ?? "")
    guard let object = recordResults?.filter(predicate).first else { return }
    recordView.changeButtonProperties(with: object, inButton: button)
  }
  
  func recordView(_ view: RecordView, didTapCancelButton button: UIButton) {
    dismissRecordViewIfExists()
    deselectTableViewIfSelected()
    
  }
  
  func recordView(_ view: RecordView,
                  didTapRankRecordButton button: UIButton,
                  inDifficulty difficulty: Difficulty,
                  inCurrentButton currentButton: Button) {
    presentRankSettingAlert(inDifficulty: difficulty, inButton: currentButton)
  }
  
  func recordView(_ view: RecordView,
                  didTapRatingRecordButton button: UIButton,
                  inDifficulty difficulty: Difficulty,
                  inCurrentButton currentButton: Button) {
    presentRatingSettingAlert(inDifficulty: difficulty, inButton: currentButton)
  }
  
  func recordView(_ view: RecordView,
                  didTapNoteRecordButton button: UIButton,
                  inDifficulty difficulty: Difficulty,
                  inCurrentButton currentButton: Button) {
    presentNoteSettingAlert(inDifficulty: difficulty, inButton: currentButton)
  }
}

// MARK: - Private Method

private extension RecordBaseTableViewController {
  
  /// Presents the alert controller to set the rank in `difficulty` and `button`.
  ///
  /// - Parameters:
  ///   - difficulty: The specific difficulty.
  ///   - button:     The specific button.
  func presentRankSettingAlert(inDifficulty difficulty: Difficulty, inButton button: Button) {
    guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
    guard let songResult = songResults?[selectedIndexPath.row] else { return }
    let predicate = NSPredicate(format: "%K == %@",
                                #keyPath(RecordInfo.title.english),
                                songResult.title?.english ?? "")
    guard let object = recordResults?.filter(predicate).first else { return }
    UIAlertController
      .alert(title: L10n.rank, message: L10n.selectTheRank)
      .action(title: "-") { [weak self] _ in
        self?.setRank(.none, with: object, inDifficulty: difficulty, inButton: button)
        self?.recordView.reloadButtonsAndLabels(with: object, inButton: button)
      }
      .action(title: Rank.s.rawValue.uppercased()) { [weak self] _ in
        self?.setRank(.s, with: object, inDifficulty: difficulty, inButton: button)
        self?.recordView.reloadButtonsAndLabels(with: object, inButton: button)
      }
      .action(title: Rank.a.rawValue.uppercased()) { [weak self] _ in
        self?.setRank(.a, with: object, inDifficulty: difficulty, inButton: button)
        self?.recordView.reloadButtonsAndLabels(with: object, inButton: button)
      }
      .action(title: Rank.b.rawValue.uppercased()) { [weak self] _ in
        self?.setRank(.b, with: object, inDifficulty: difficulty, inButton: button)
        self?.recordView.reloadButtonsAndLabels(with: object, inButton: button)
      }
      .action(title: Rank.c.rawValue.uppercased()) { [weak self] _ in
        self?.setRank(.c, with: object, inDifficulty: difficulty, inButton: button)
        self?.recordView.reloadButtonsAndLabels(with: object, inButton: button)
      }
      .action(title: L10n.cancel, style: .cancel)
      .present(to: self)
  }
  
  /// Presents the alert controller to set the rating in `difficulty` and `button`.
  ///
  /// - Parameters:
  ///   - difficulty: The specific difficulty.
  ///   - button:     The specific button.
  func presentRatingSettingAlert(inDifficulty difficulty: Difficulty, inButton button: Button) {
    guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
    guard let songResult = songResults?[selectedIndexPath.row] else { return }
    let predicate = NSPredicate(format: "%K == %@",
                                #keyPath(RecordInfo.title.english),
                                songResult.title?.english ?? "")
    guard let object = recordResults?.filter(predicate).first else { return }
    let message = L10n.EnterTheRate.toResetTheValueDoNotEnterAnyValues
    let alert = UIAlertController
      .alert(title: L10n.rating, message: message.localized)
    alert.textField {
      $0.keyboardType = .decimalPad
      $0.placeholder = L10n.rating
      }
      .action(title: L10n.ok) { [weak self] _ in
        let input = alert.textFields?.first?.text ?? ""
        if input.isEmpty {
          self?.setRating(0, with: object, inDifficulty: difficulty, inButton: button)
        } else {
          guard let value = Double(input) else { return }
          let rating = value >= 100 ? 100 : value
          self?.setRating(rating, with: object, inDifficulty: difficulty, inButton: button)
          switch rating {
          case 98...100:
            self?.setRank(.s, with: object, inDifficulty: difficulty, inButton: button)
          case 95..<98:
            self?.setRank(.a, with: object, inDifficulty: difficulty, inButton: button)
          case 90..<95:
            self?.setRank(.b, with: object, inDifficulty: difficulty, inButton: button)
          case ..<90:
            self?.setRank(.c, with: object, inDifficulty: difficulty, inButton: button)
          default:
            break
          }
        }
        self?.recordView.reloadButtonsAndLabels(with: object, inButton: button)
        guard let buttonExpansion = button.expansion else { return }
        guard let note
          = object.value(forKeyPath: "\(buttonExpansion).\(difficulty).note") as? String
          else { return }
        let noteEnum = Note(rawValue: note) ?? .none
        if noteEnum != .maxCombo {
          self?.presentNoteSettingAlert(inDifficulty: difficulty, inButton: button)
        }
      }
      .action(title: L10n.cancel, style: .cancel)
      .present(to: self)
  }
  
  /// Presents the alert controller to set the note in `difficulty` and `button`.
  ///
  /// - Parameters:
  ///   - difficulty: The specific difficulty.
  ///   - button:     The specific button.
  func presentNoteSettingAlert(inDifficulty difficulty: Difficulty, inButton button: Button) {
    guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
    guard let songResult = songResults?[selectedIndexPath.row] else { return }
    let predicate = NSPredicate(format: "%K == %@",
                                #keyPath(RecordInfo.title.english),
                                songResult.title?.english ?? "")
    guard let object = recordResults?.filter(predicate).first else { return }
    UIAlertController
      .alert(title: L10n.note, message: L10n.selectTheNote)
      .action(title: "-") { [weak self] _ in
        self?.setNote(.none, with: object, inDifficulty: difficulty, inButton: button)
        self?.recordView.reloadButtonsAndLabels(with: object, inButton: button)
      }
      .action(title: Note.maxCombo.expansion) { [weak self] _ in
        self?.setNote(.maxCombo, with: object, inDifficulty: difficulty, inButton: button)
        self?.recordView.reloadButtonsAndLabels(with: object, inButton: button)
      }
      .action(title: Note.perfectPlay.expansion) { [weak self] _ in
        self?.setRank(.s, with: object, inDifficulty: difficulty, inButton: button)
        self?.setRating(100, with: object, inDifficulty: difficulty, inButton: button)
        self?.setNote(.perfectPlay, with: object, inDifficulty: difficulty, inButton: button)
        self?.recordView.reloadButtonsAndLabels(with: object, inButton: button)
      }
      .action(title: L10n.cancel, style: .cancel)
      .present(to: self)
  }
  
  /// Sets `rank` with `recordInfo` in `difficulty` and `button`.
  ///
  /// - Parameters:
  ///   - rank:       The rank will be saved.
  ///   - recordInfo: The record information will be updated.
  ///   - difficulty: The specific difficulty.
  ///   - button:     The specific button.
  func setRank(_ rank: Rank,
               with recordInfo: RecordInfo,
               inDifficulty difficulty: Difficulty,
               inButton button: Button) {
    let keyPath = "\(button.expansion ?? "").\(difficulty.rawValue).rank"
    RecordInfo.update(recordInfo, with: [keyPath: rank.rawValue.uppercased()])
  }
  
  /// Sets `rating` with `recordInfo` in `difficulty` and `button`.
  ///
  /// - Parameters:
  ///   - rating:     The rating will be saved.
  ///   - recordInfo: The record information will be updated.
  ///   - difficulty: The specific difficulty.
  ///   - button:     The specific button.
  func setRating(_ rating: Double,
                 with recordInfo: RecordInfo,
                 inDifficulty difficulty: Difficulty,
                 inButton button: Button) {
    let keyPath = "\(button.expansion ?? "").\(difficulty.rawValue).rate"
    RecordInfo.update(recordInfo, with: [keyPath: rating])
    updateSkillPoint(with: recordInfo, inButton: button)
    recordView.updateRankingAndSkillPointLabel(with: recordInfo, inButton: button)
  }
  
  /// Sets `note` with `recordInfo` in `difficulty` and `button`.
  ///
  /// - Parameters:
  ///   - note:       The note will be saved.
  ///   - recordInfo: The record information will be updated.
  ///   - difficulty: The specific difficulty.
  ///   - button:     The specific button.
  func setNote(_ note: Note,
               with recordInfo: RecordInfo,
               inDifficulty difficulty: Difficulty,
               inButton button: Button) {
    let keyPath = "\(button.expansion ?? "").\(difficulty.rawValue).note"
    RecordInfo.update(recordInfo, with: [keyPath: note.rawValue])
    updateSkillPoint(with: recordInfo, inButton: button)
    recordView.updateRankingAndSkillPointLabel(with: recordInfo, inButton: button)
  }
  
  /// Updates skill point with `recordInfo` in `button`.
  ///
  /// - Parameters:
  ///   - recordInfo: The record information will be updated.
  ///   - button:     The specific button.
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
  
  /// Dismisses record view if it is presenting.
  func dismissRecordViewIfExists() {
    if let lastSubview = recordViewController.view.subviews.last as? RecordView {
      lastSubview.removeFromSuperview()
      recordViewController.scrollViewBottomConstraint.constant -= 210
    }
  }
  
  /// Deselects table view if it is selected.
  func deselectTableViewIfSelected() {
    if let selectedIndexPath = self.tableView.indexPathForSelectedRow {
      guard let cell = tableView.cellForRow(at: selectedIndexPath) as? RecordCell else { return }
      tableView.deselectRow(at: selectedIndexPath, animated: true)
      cell.decolorizeSubviews()
    }
  }
}
