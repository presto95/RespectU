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
    func touchUpTypeButton(_ sender: UIButton)
    func presentRankAlert(difficulty: String, button: String)
    func presentRateAlert(difficulty: String, button: String)
    func presentNoteAlert(difficulty: String, button: String)
    func touchUpCancelButton()
}

class RecordView: UIView {

    var delegate: RecordViewDelegate?
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
    @IBOutlet weak var rankLabel: UILabel!
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
        self.layer.borderWidth = 3
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.main.cgColor
        self.cancelButton.setTitle("Cancel".localized, for: .normal)
        self.cancelButton.addTarget(self, action: #selector(touchUpCancelButton(_:)), for: .touchUpInside)
    }
    
    @IBAction func touchUpOtherButtons(_ sender: UIButton) {
        let button = buttonButton.titleLabel?.text ?? "4B"
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
    
    @IBAction func touchUpTypeButton(_ sender: UIButton) {
        delegate?.touchUpTypeButton(sender)
    }
    
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        delegate?.touchUpCancelButton()
    }
}

extension RecordView {
    func changeButton(_ object: RecordInfo, button: String) {
        switch button {
        case Buttons.button4:
            self.buttonButton.setTitle(Buttons.button5, for: .normal)
            reloadButtonsAndLabels(object, button: Buttons.button5)
        case Buttons.button5:
            self.buttonButton.setTitle(Buttons.button6, for: .normal)
            reloadButtonsAndLabels(object, button: Buttons.button6)
        case Buttons.button6:
            self.buttonButton.setTitle(Buttons.button8, for: .normal)
            reloadButtonsAndLabels(object, button: Buttons.button8)
        case Buttons.button8:
            self.buttonButton.setTitle(Buttons.button4, for: .normal)
            reloadButtonsAndLabels(object, button: Buttons.button4)
        default:
            break
        }
    }
    
    func updateRankAndSkillPointLabel(_ object: RecordInfo, button: String) {
        updateSkillPointLabel(object, button: button)
        updateRankLabel(title: object.title, button: button)
    }
    
    func reloadButtonsAndLabels(_ object: RecordInfo, button: String) {
        self.buttonButton.setTitle(button, for: .normal)
        self.titleLabel.text = object.title
        let normalButtons = [normalRankButton, normalRateButton, normalNoteButton]
        let hardButtons = [hardRankButton, hardRateButton, hardNoteButton]
        let maximumButtons = [maximumRankButton, maximumRateButton, maximumNoteButton]
        for index in 0..<3 {
            normalButtons[index]?.isEnabled = true
            hardButtons[index]?.isEnabled = true
            maximumButtons[index]?.isEnabled = true
        }
        var buttonInteger = 0
        switch button {
        case Buttons.button4:
            buttonInteger = 4
        case Buttons.button5:
            buttonInteger = 5
        case Buttons.button6:
            buttonInteger = 6
        case Buttons.button8:
            buttonInteger = 8
        default:
            break
        }
        updateRankLabel(title: object.title, button: button)
        skillPointLabel.text = "\(object.value(forKey: "button\(buttonInteger)SkillPoint") as? Double ?? 0) " + "Point".localized
        if object.value(forKey: "nm\(buttonInteger)") as? Int ?? 0 == 0 {
            for button in normalButtons {
                button?.isEnabled = false
                button?.setTitle("None".localized, for: .normal)
            }
            normalLabel.text = nil
        } else {
            normalRankButton.setTitle(object.value(forKey: "nm\(buttonInteger)Rank") as? String ?? Rank.none, for: .normal)
            normalRateButton.setTitle(object.value(forKey: "nm\(buttonInteger)Rate") as? String ?? "-", for: .normal)
            normalNoteButton.setTitle((object.value(forKey: "nm\(buttonInteger)Note") as? String ?? Note.none).noteAbbreviation, for: .normal)
            normalLabel.text = "\(object.value(forKey: "nm\(buttonInteger)") as? Int ?? 0)"
        }
        if object.value(forKey: "hd\(buttonInteger)") as? Int ?? 0 == 0 {
            for button in hardButtons {
                button?.isEnabled = false
                button?.setTitle("None".localized, for: .normal)
            }
            hardLabel.text = nil
        } else {
            hardRankButton.setTitle(object.value(forKey: "hd\(buttonInteger)Rank") as? String ?? Rank.none, for: .normal)
            hardRateButton.setTitle(object.value(forKey: "hd\(buttonInteger)Rate") as? String ?? "-", for: .normal)
            hardNoteButton.setTitle((object.value(forKey: "hd\(buttonInteger)Note") as? String ?? Note.none).noteAbbreviation, for: .normal)
            hardLabel.text = "\(object.value(forKey: "hd\(buttonInteger)") as? Int ?? 0)"
        }
        if object.value(forKey: "mx\(buttonInteger)") as? Int ?? 0 == 0 {
            for button in maximumButtons {
                button?.isEnabled = false
                button?.setTitle("None".localized, for: .normal)
            }
            maximumLabel.text = nil
        } else {
            maximumRankButton.setTitle(object.value(forKey: "mx\(buttonInteger)Rank") as? String ?? Rank.none, for: .normal)
            maximumRateButton.setTitle(object.value(forKey: "mx\(buttonInteger)Rate") as? String ?? "-", for: .normal)
            maximumNoteButton.setTitle((object.value(forKey: "mx\(buttonInteger)Note") as? String ?? Note.none).noteAbbreviation, for: .normal)
            maximumLabel.text = "\(object.value(forKey: "mx\(buttonInteger)") as? Int ?? 0)"
        }
    }
    
    private func updateSkillPointLabel(_ object: RecordInfo, button: String) {
        switch button {
        case Buttons.button4:
            self.skillPointLabel.text = "\(object.button4SkillPoint) " + "Point".localized
        case Buttons.button5:
            self.skillPointLabel.text = "\(object.button5SkillPoint) " + "Point".localized
        case Buttons.button6:
            self.skillPointLabel.text = "\(object.button6SkillPoint) " + "Point".localized
        case Buttons.button8:
            self.skillPointLabel.text = "\(object.button8SkillPoint) " + "Point".localized
        default:
            break
        }
    }
    
    private func updateRankLabel(title: String, button: String) {
        let top50Results: Results<RecordInfo>
        switch button {
        case Buttons.button4:
             top50Results = RecordInfo.get().sorted(byKeyPath: Skill.button4SkillPoint, ascending: false)
        case Buttons.button5:
            top50Results = RecordInfo.get().sorted(byKeyPath: Skill.button5SkillPoint, ascending: false)
        case Buttons.button6:
            top50Results = RecordInfo.get().sorted(byKeyPath: Skill.button6SkillPoint, ascending: false)
        case Buttons.button8:
            top50Results = RecordInfo.get().sorted(byKeyPath: Skill.button8SkillPoint, ascending: false)
        default:
            top50Results = RecordInfo.get()
        }
        let query = NSPredicate(format: "title = %@", title)
        guard let filtered = top50Results.filter(query).first else { return }
        guard let index = top50Results.index(of: filtered) else { return }
        if index < 50 {
            self.rankLabel.text = "#\(index + 1)"
        } else {
            self.rankLabel.text = "Out of Rank".localized
        }
    }
}


