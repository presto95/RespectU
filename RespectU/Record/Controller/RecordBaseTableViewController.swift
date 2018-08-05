//
//  RecordBaseTableViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import RealmSwift

class RecordBaseTableViewController: BaseTableViewController {

    var recordViewController: RecordViewController {
        guard let parent = self.parent as? RecordViewController else { return RecordViewController() }
        return parent
    }
    let favoriteButton = UserDefaults.standard.string(forKey: "favoriteButton") ?? "4B"
    var results: Results<RecordInfo>!
    var recordView: RecordView!
    let cellIdentifier = "recordCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "RecordCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        dismissRecordViewIfExists()
        deselectTableViewIfSelected()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RecordCell else { return UITableViewCell() }
        let object = self.results[indexPath.row]
        cell.setProperties(object)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.results.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? RecordCell else { return }
        dismissRecordViewIfExists()
        let object = self.results[indexPath.row]
        cell.setColorWhenSelected(object.series)
        self.recordView = UIView.instanceFromXib(xibName: "RecordView") as? RecordView
        self.recordView.delegate = self
        self.recordView.reloadButtonsAndLabels(object, button: favoriteButton)
        self.recordView.frame = CGRect(x: 0, y: recordViewController.view.bounds.height - 210, width: recordViewController.view.bounds.width, height: 200)
        recordViewController.scrollViewBottomConstraint.constant += 200
        recordViewController.view.addSubview(recordView)
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? RecordCell else { return }
        cell.setColorWhenDeselected()
    }
}

extension RecordBaseTableViewController {
    func setRank(_ object: RecordInfo, rank: String, difficulty: String, button: String) {
        let key: String = {
            switch button {
            case Buttons.button4:
                switch difficulty {
                case Difficulty.normal:
                    return "nm4Rank"
                case Difficulty.hard:
                    return "hd4Rank"
                case Difficulty.maximum:
                    return "mx4Rank"
                default:
                    return ""
                }
            case Buttons.button5:
                switch difficulty {
                case Difficulty.normal:
                    return "nm5Rank"
                case Difficulty.hard:
                    return "hd5Rank"
                case Difficulty.maximum:
                    return "mx5Rank"
                default:
                    return ""
                }
            case Buttons.button6:
                switch difficulty {
                case Difficulty.normal:
                    return "nm6Rank"
                case Difficulty.hard:
                    return "hd6Rank"
                case Difficulty.maximum:
                    return "mx6Rank"
                default:
                    return ""
                }
            case Buttons.button8:
                switch difficulty {
                case Difficulty.normal:
                    return "nm8Rank"
                case Difficulty.hard:
                    return "hd8Rank"
                case Difficulty.maximum:
                    return "mx8Rank"
                default:
                    return ""
                }
            default:
                return ""
            }
        }()
        RecordInfo.update(object, with: [key: rank])
    }
    
    func setRate(_ object: RecordInfo, rate: String, difficulty: String, button: String) {
        let value: String
        if rate.isEmpty {
            value = "-"
        } else {
            guard let double = Double(rate) else { return }
            value = String(format: "%05.2f%%", double)
        }
        let key: String = {
            switch button {
            case Buttons.button4:
                switch difficulty {
                case Difficulty.normal:
                    return "nm4Rate"
                case Difficulty.hard:
                    return "hd4Rate"
                case Difficulty.maximum:
                    return "mx4Rate"
                default:
                    return ""
                }
            case Buttons.button5:
                switch difficulty {
                case Difficulty.normal:
                    return "nm5Rate"
                case Difficulty.hard:
                    return "hd5Rate"
                case Difficulty.maximum:
                    return "mx5Rate"
                default:
                    return ""
                }
            case Buttons.button6:
                switch difficulty {
                case Difficulty.normal:
                    return "nm6Rate"
                case Difficulty.hard:
                    return "hd6Rate"
                case Difficulty.maximum:
                    return "mx6Rate"
                default:
                    return ""
                }
            case Buttons.button8:
                switch difficulty {
                case Difficulty.normal:
                    return "nm8Rate"
                case Difficulty.hard:
                    return "hd8Rate"
                case Difficulty.maximum:
                    return "mx8Rate"
                default:
                    return ""
                }
            default:
                return ""
            }
        }()
        RecordInfo.update(object, with: [key: value])
        setHighestSkillPoint(object, button: button)
        recordView.updateRankAndSkillPointLabel(object, button: button)
    }
    
    func setNote(_ object: RecordInfo, note: String, difficulty: String, button: String) {
        let key: String = {
            switch button {
            case Buttons.button4:
                switch difficulty {
                case Difficulty.normal:
                    return "nm4Note"
                case Difficulty.hard:
                    return "hd4Note"
                case Difficulty.maximum:
                    return "mx4Note"
                default:
                    return ""
                }
            case Buttons.button5:
                switch difficulty {
                case Difficulty.normal:
                    return "nm5Note"
                case Difficulty.hard:
                    return "hd5Note"
                case Difficulty.maximum:
                    return "mx5Note"
                default:
                    return ""
                }
            case Buttons.button6:
                switch difficulty {
                case Difficulty.normal:
                    return "nm6Note"
                case Difficulty.hard:
                    return "hd6Note"
                case Difficulty.maximum:
                    return "mx6Note"
                default:
                    return ""
                }
            case Buttons.button8:
                switch difficulty {
                case Difficulty.normal:
                    return "nm8Note"
                case Difficulty.hard:
                    return "hd8Note"
                case Difficulty.maximum:
                    return "mx8Note"
                default:
                    return ""
                }
            default:
                return ""
            }
        }()
        RecordInfo.update(object, with: [key: note])
        setHighestSkillPoint(object, button: button)
        recordView.updateRankAndSkillPointLabel(object, button: button)
    }
    
    func setHighestSkillPoint(_ object: RecordInfo, button: String) {
        switch button {
        case Buttons.button4:
            let normalButton4SkillPoint = Skill.skillPoint(difficulty: object.nm4, rate: object.nm4Rate, note: object.nm4Note)
            let hardButton4SkillPoint = Skill.skillPoint(difficulty: object.hd4, rate: object.hd4Rate, note: object.hd4Note)
            let maximumButton4SkillPoint = Skill.skillPoint(difficulty: object.mx4, rate: object.mx4Rate, note: object.mx4Note)
            guard let maxButton4SkillPoint = [normalButton4SkillPoint, hardButton4SkillPoint, maximumButton4SkillPoint].sorted().last else { return }
            RecordInfo.update(object, with: [Skill.button4SkillPoint: maxButton4SkillPoint])
            switch maximumButton4SkillPoint {
            case normalButton4SkillPoint:
                RecordInfo.update(object, with: [
                    Skill.button4HighestSkillPointRate: object.nm4Rate,
                    Skill.button4HighestSkillPointDifficulty: Difficulty.normal,
                    Skill.button4HighestSkillPointNote: object.nm4Note
                    ])
            case hardButton4SkillPoint:
                RecordInfo.update(object, with: [
                    Skill.button4HighestSkillPointRate: object.hd4Rate,
                    Skill.button4HighestSkillPointDifficulty: Difficulty.hard,
                    Skill.button4HighestSkillPointNote: object.hd4Note
                    ])
            case maximumButton4SkillPoint:
                RecordInfo.update(object, with: [
                    Skill.button4HighestSkillPointRate: object.mx4Rate,
                    Skill.button4HighestSkillPointDifficulty: Difficulty.maximum,
                    Skill.button4HighestSkillPointNote: object.mx4Note
                    ])
            default:
                break
            }
        case Buttons.button5:
            let normalButton5SkillPoint = Skill.skillPoint(difficulty: object.nm5, rate: object.nm5Rate, note: object.nm5Note)
            let hardButton5SkillPoint = Skill.skillPoint(difficulty: object.hd5, rate: object.hd5Rate, note: object.hd5Note)
            let maximumButton5SkillPoint = Skill.skillPoint(difficulty: object.mx5, rate: object.mx5Rate, note: object.mx5Note)
            guard let maxButton5SkillPoint = [normalButton5SkillPoint, hardButton5SkillPoint, maximumButton5SkillPoint].sorted().last else { return }
            RecordInfo.update(object, with: [Skill.button5SkillPoint: maxButton5SkillPoint])
            switch maximumButton5SkillPoint {
            case normalButton5SkillPoint:
                RecordInfo.update(object, with: [
                    Skill.button5HighestSkillPointRate: object.nm5Rate,
                    Skill.button5HighestSkillPointDifficulty: Difficulty.normal,
                    Skill.button5HighestSkillPointNote: object.nm5Note
                    ])
            case hardButton5SkillPoint:
                RecordInfo.update(object, with: [
                    Skill.button5HighestSkillPointRate: object.hd5Rate,
                    Skill.button5HighestSkillPointDifficulty: Difficulty.hard,
                    Skill.button5HighestSkillPointNote: object.hd5Note
                    ])
            case maximumButton5SkillPoint:
                RecordInfo.update(object, with: [
                    Skill.button5HighestSkillPointRate: object.mx5Rate,
                    Skill.button5HighestSkillPointDifficulty: Difficulty.maximum,
                    Skill.button5HighestSkillPointNote: object.mx5Note
                    ])
            default:
                break
            }
        case Buttons.button6:
            let normalButton6SkillPoint = Skill.skillPoint(difficulty: object.nm6, rate: object.nm6Rate, note: object.nm6Note)
            let hardButton6SkillPoint = Skill.skillPoint(difficulty: object.hd6, rate: object.hd6Rate, note: object.hd6Note)
            let maximumButton6SkillPoint = Skill.skillPoint(difficulty: object.mx6, rate: object.mx6Rate, note: object.mx6Note)
            guard let maxButton6SkillPoint = [normalButton6SkillPoint, hardButton6SkillPoint, maximumButton6SkillPoint].sorted().last else { return }
            RecordInfo.update(object, with: [Skill.button6SkillPoint: maxButton6SkillPoint])
            switch maximumButton6SkillPoint {
            case normalButton6SkillPoint:
                RecordInfo.update(object, with: [
                    Skill.button6HighestSkillPointRate: object.nm6Rate,
                    Skill.button6HighestSkillPointDifficulty: Difficulty.normal,
                    Skill.button6HighestSkillPointNote: object.nm6Note
                    ])
            case hardButton6SkillPoint:
                RecordInfo.update(object, with: [
                    Skill.button6HighestSkillPointRate: object.hd6Rate,
                    Skill.button6HighestSkillPointDifficulty: Difficulty.hard,
                    Skill.button6HighestSkillPointNote: object.hd6Note
                    ])
            case maximumButton6SkillPoint:
                RecordInfo.update(object, with: [
                    Skill.button6HighestSkillPointRate: object.mx6Rate,
                    Skill.button6HighestSkillPointDifficulty: Difficulty.maximum,
                    Skill.button6HighestSkillPointNote: object.mx6Note
                    ])
            default:
                break
            }
        case Buttons.button8:
            let normalButton8SkillPoint = Skill.skillPoint(difficulty: object.nm8, rate: object.nm8Rate, note: object.nm8Note)
            let hardButton8SkillPoint = Skill.skillPoint(difficulty: object.hd8, rate: object.hd8Rate, note: object.hd8Note)
            let maximumButton8SkillPoint = Skill.skillPoint(difficulty: object.mx8, rate: object.mx8Rate, note: object.mx8Note)
            guard let maxButton8SkillPoint = [normalButton8SkillPoint, hardButton8SkillPoint, maximumButton8SkillPoint].sorted().last else { return }
            RecordInfo.update(object, with: [Skill.button8SkillPoint: maxButton8SkillPoint])
            switch maximumButton8SkillPoint {
            case normalButton8SkillPoint:
                RecordInfo.update(object, with: [
                    Skill.button8HighestSkillPointRate: object.nm8Rate,
                    Skill.button8HighestSkillPointDifficulty: Difficulty.normal,
                    Skill.button8HighestSkillPointNote: object.nm8Note
                    ])
            case hardButton8SkillPoint:
                RecordInfo.update(object, with: [
                    Skill.button8HighestSkillPointRate: object.hd8Rate,
                    Skill.button8HighestSkillPointDifficulty: Difficulty.hard,
                    Skill.button8HighestSkillPointNote: object.hd8Note
                    ])
            case maximumButton8SkillPoint:
                RecordInfo.update(object, with: [
                    Skill.button8HighestSkillPointRate: object.mx8Rate,
                    Skill.button8HighestSkillPointDifficulty: Difficulty.maximum,
                    Skill.button8HighestSkillPointNote: object.mx8Note
                    ])
            default:
                break
            }
        default:
            break
        }
    }
    
    func dismissRecordViewIfExists() {
        let lastSubview = recordViewController.view.subviews.last
        if lastSubview is RecordView {
            lastSubview?.removeFromSuperview()
            recordViewController.scrollViewBottomConstraint.constant -= 200
        }
    }
    
    func deselectTableViewIfSelected() {
        if let selectedIndexPath = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: selectedIndexPath, animated: true)
        }
    }
}

extension RecordBaseTableViewController: RecordViewDelegate {
    func touchUpTypeButton(_ sender: UIButton) {
        let button = sender.title(for: .normal) ?? Buttons.button4
        guard let selectedIndexPath = self.tableView.indexPathForSelectedRow else { return }
        let object = self.results[selectedIndexPath.row]
        recordView.changeButton(object, button: button)
    }
    
    func presentRankAlert(difficulty: String, button: String) {
        guard let selectedIndexPath = self.tableView.indexPathForSelectedRow else { return }
        let object = self.results[selectedIndexPath.row]
        UIAlertController
            .alert(title: "Rank".localized, message: "Select your rank.".localized)
            .defaultAction(title: Rank.none) { [unowned self] action in
                self.setRank(object, rank: Rank.none, difficulty: difficulty, button: button)
                self.recordView.reloadButtonsAndLabels(object, button: button)
            }
            .defaultAction(title: Rank.s) { [unowned self] action in
                self.setRank(object, rank: Rank.s, difficulty: difficulty, button: button)
                self.recordView.reloadButtonsAndLabels(object, button: button)
            }
            .defaultAction(title: Rank.a) { [unowned self] action in
                self.setRank(object, rank: Rank.a, difficulty: difficulty, button: button)
                self.recordView.reloadButtonsAndLabels(object, button: button)
            }
            .defaultAction(title: Rank.b) { [unowned self] action in
                self.setRank(object, rank: Rank.b, difficulty: difficulty, button: button)
                self.recordView.reloadButtonsAndLabels(object, button: button)
            }
            .defaultAction(title: Rank.c) { [unowned self] action in
                self.setRank(object, rank: Rank.c, difficulty: difficulty, button: button)
                self.recordView.reloadButtonsAndLabels(object, button: button)
            }
            .cancelAction(title: "Cancel".localized)
            .present(to: self)
    }
    
    func presentRateAlert(difficulty: String, button: String) {
        guard let selectedIndexPath = self.tableView.indexPathForSelectedRow else { return }
        let object = self.results[selectedIndexPath.row]
        let alert = UIAlertController
            .alert(title: "Rate".localized, message: "Input your rate.\nTo reset the value, do not enter any values.".localized)
        alert.textField { textField in
            textField.keyboardType = .decimalPad
            textField.placeholder = "Rate".localized
        }
            .defaultAction(title: "OK".localized) { [unowned self] action in
                let input = alert.textFields?.first?.text ?? ""
                if input.isEmpty {
                    self.setRate(object, rate: "", difficulty: difficulty, button: button)
                } else {
                    guard let value = Double(input) else { return }
                    let rate = value >= 100 ? "\(100.00)" : input
                    self.setRate(object, rate: rate, difficulty: difficulty, button: button)
                    switch value {
                    case 98...100:
                        self.setRank(object, rank: Rank.s, difficulty: difficulty, button: button)
                    case 95..<98:
                        self.setRank(object, rank: Rank.a, difficulty: difficulty, button: button)
                    case 90..<95:
                        self.setRank(object, rank: Rank.b, difficulty: difficulty, button: button)
                    case 0..<90:
                        self.setRank(object, rank: Rank.c, difficulty: difficulty, button: button)
                    default:
                        break
                    }
                }
                self.recordView.reloadButtonsAndLabels(object, button: button)
                switch button {
                case Buttons.button4:
                    switch difficulty {
                    case Difficulty.normal:
                        if object.nm4Note != Note.maxCombo {
                            self.presentNoteAlert(difficulty: difficulty, button: button)
                        }
                    case Difficulty.hard:
                        if object.hd4Note != Note.maxCombo {
                            self.presentNoteAlert(difficulty: difficulty, button: button)
                        }
                    case Difficulty.maximum:
                        if object.mx4Note != Note.maxCombo {
                            self.presentNoteAlert(difficulty: difficulty, button: button)
                        }
                    default:
                        break
                    }
                case Buttons.button5:
                    switch difficulty {
                    case Difficulty.normal:
                        if object.nm5Note != Note.maxCombo {
                            self.presentNoteAlert(difficulty: difficulty, button: button)
                        }
                    case Difficulty.hard:
                        if object.hd5Note != Note.maxCombo {
                            self.presentNoteAlert(difficulty: difficulty, button: button)
                        }
                    case Difficulty.maximum:
                        if object.mx5Note != Note.maxCombo {
                            self.presentNoteAlert(difficulty: difficulty, button: button)
                        }
                    default:
                        break
                    }
                case Buttons.button6:
                    switch difficulty {
                    case Difficulty.normal:
                        if object.nm6Note != Note.maxCombo {
                            self.presentNoteAlert(difficulty: difficulty, button: button)
                        }
                    case Difficulty.hard:
                        if object.hd6Note != Note.maxCombo {
                            self.presentNoteAlert(difficulty: difficulty, button: button)
                        }
                    case Difficulty.maximum:
                        if object.mx6Note != Note.maxCombo {
                            self.presentNoteAlert(difficulty: difficulty, button: button)
                        }
                    default:
                        break
                    }
                case Buttons.button8:
                    switch difficulty {
                    case Difficulty.normal:
                        if object.nm8Note != Note.maxCombo {
                            self.presentNoteAlert(difficulty: difficulty, button: button)
                        }
                    case Difficulty.hard:
                        if object.hd8Note != Note.maxCombo {
                            self.presentNoteAlert(difficulty: difficulty, button: button)
                        }
                    case Difficulty.maximum:
                        if object.mx8Note != Note.maxCombo {
                            self.presentNoteAlert(difficulty: difficulty, button: button)
                        }
                    default:
                        break
                    }
                default:
                    break
                }
            }
            .cancelAction(title: "Cancel".localized)
            .present(to: self)
    }
    
    func presentNoteAlert(difficulty: String, button: String) {
        guard let selectedIndexPath = self.tableView.indexPathForSelectedRow else { return }
        let object = self.results[selectedIndexPath.row]
        UIAlertController
            .alert(title: "Note".localized, message: "Select your note.".localized)
            .defaultAction(title: Note.none) { [unowned self] action in
                self.setNote(object, note: Note.none, difficulty: difficulty, button: button)
                self.recordView.reloadButtonsAndLabels(object, button: button)
            }
            .defaultAction(title: Note.maxCombo) { [unowned self] action in
                self.setNote(object, note: Note.maxCombo, difficulty: difficulty, button: button)
                self.recordView.reloadButtonsAndLabels(object, button: button)
            }
            .defaultAction(title: Note.perfectPlay) { [unowned self] action in
                self.setRank(object, rank: Rank.s, difficulty: difficulty, button: button)
                self.setRate(object, rate: "100", difficulty: difficulty, button: button)
                self.setNote(object, note: Note.perfectPlay, difficulty: difficulty, button: button)
                self.recordView.reloadButtonsAndLabels(object, button: button)
            }
            .cancelAction(title: "Cancel".localized)
            .present(to: self)
    }
    
    func dismiss() {
        dismissRecordViewIfExists()
        deselectTableViewIfSelected()
    }
}
