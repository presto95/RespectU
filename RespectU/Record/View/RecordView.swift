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
    func dismiss()
}

class RecordView: UIView {

    var delegate: RecordViewDelegate?
    var results: Results<RecordInfo>!
    var query: NSPredicate!
    var object: RecordInfo!
    var top50Results: Results<RecordInfo>!
    var title: String = ""
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var skillPointLabel: UILabel!
    @IBOutlet weak var typeButton: UIButton!
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.results = RecordInfo.get()
        let favoriteButton = UserDefaults.standard.string(forKey: "favoriteButton") ?? "4B"
        self.cancelButton.setTitle("Cancel".localized, for: .normal)
        self.typeButton.setTitle(favoriteButton, for: .normal)
        self.titleLabel.text = title
        self.query = NSPredicate(format: "title = %@", title)
        self.object = results.filter(query).first
        reloadButtonsAndLabels(button: favoriteButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.borderWidth = 3
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.main.cgColor
    }
    
    @IBAction func touchUpTypeButton(_ sender: UIButton) {
        delegate?.touchUpTypeButton(sender)
    }
    
    @IBAction func touchUpOtherButtons(_ sender: UIButton) {
        let button = typeButton.titleLabel?.text ?? "4B"
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
    
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        delegate?.dismiss()
    }
    
    func changeButton(button: String) {
        switch button {
        case Buttons.button4:
            self.typeButton.setTitle(Buttons.button5, for: .normal)
            reloadButtonsAndLabels(button: Buttons.button5)
        case Buttons.button5:
            self.typeButton.setTitle(Buttons.button6, for: .normal)
            reloadButtonsAndLabels(button: Buttons.button6)
        case Buttons.button6:
            self.typeButton.setTitle(Buttons.button8, for: .normal)
            reloadButtonsAndLabels(button: Buttons.button8)
        case Buttons.button8:
            self.typeButton.setTitle(Buttons.button4, for: .normal)
            reloadButtonsAndLabels(button: Buttons.button4)
        default:
            break
        }
    }
    
    func updateRankAndSkillPointLabel(button: String) {
        let query = NSPredicate(format: "title = %@", title)
        switch button {
        case Buttons.button4:
            self.skillPointLabel.text = "\(object.button4SkillPoint) " + "Point".localized
            self.top50Results = RecordInfo.get().sorted(byKeyPath: Skill.button4SkillPoint, ascending: false)
        case Buttons.button5:
            self.skillPointLabel.text = "\(object.button5SkillPoint) " + "Point".localized
            self.top50Results = RecordInfo.get().sorted(byKeyPath: Skill.button5SkillPoint, ascending: false)
        case Buttons.button6:
            self.skillPointLabel.text = "\(object.button6SkillPoint) " + "Point".localized
            self.top50Results = RecordInfo.get().sorted(byKeyPath: Skill.button6SkillPoint, ascending: false)
        case Buttons.button8:
            self.skillPointLabel.text = "\(object.button8SkillPoint) " + "Point".localized
            self.top50Results = RecordInfo.get().sorted(byKeyPath: Skill.button8SkillPoint, ascending: false)
        default:
            break
        }
        guard let filtered = top50Results.filter(query).first else { return }
        guard let index = self.top50Results.index(of: filtered) else { return }
        if index < 50 {
            self.rankLabel.text = "#\(index + 1)"
        } else {
            self.rankLabel.text = "Out of Rank".localized
        }
    }
   
    func reloadButtonsAndLabels(button: String) {
        let normalButtons = [normalRankButton, normalRateButton, normalNoteButton]
        let hardButtons = [hardRankButton, hardRateButton, hardNoteButton]
        let maximumButtons = [maximumRankButton, maximumRateButton, maximumNoteButton]
        for index in 0..<3 {
            normalButtons[index]?.isEnabled = true
            hardButtons[index]?.isEnabled = true
            maximumButtons[index]?.isEnabled = true
        }
        switch button {
        case Buttons.button4:
            top50Results = RecordInfo.get().sorted(byKeyPath: Skill.button4SkillPoint, ascending: false)
            guard let filtered = top50Results.filter(query).first else { return }
            guard let index = self.top50Results.index(of: filtered) else { return }
            if index < 50 {
                self.rankLabel.text = "#\(index + 1)"
            } else {
                self.rankLabel.text = "Out of Rank".localized
            }
            skillPointLabel.text = "\(object.button4SkillPoint) " + "Point".localized
            if object.nm4 == 0 {
                for button in normalButtons {
                    button?.isEnabled = false
                    button?.setTitle("None".localized, for: .normal)
                }
                normalLabel.text = nil
            } else {
                normalRankButton.setTitle(object.nm4Rank, for: .normal)
                normalRateButton.setTitle(object.nm4Rate, for: .normal)
                normalNoteButton.setTitle(object.nm4Note.noteAbbreviation, for: .normal)
                normalLabel.text = "\(object.nm4)"
            }
            if object.hd4 == 0 {
                for button in hardButtons {
                    button?.isEnabled = false
                    button?.setTitle("None".localized, for: .normal)
                }
                hardLabel.text = nil
            } else {
                hardRankButton.setTitle(object.hd4Rank, for: .normal)
                hardRateButton.setTitle(object.hd4Rate, for: .normal)
                hardNoteButton.setTitle(object.hd4Note.noteAbbreviation, for: .normal)
                hardLabel.text = "\(object.hd4)"
            }
            if object.mx4 == 0 {
                for button in maximumButtons {
                    button?.isEnabled = false
                    button?.setTitle("None".localized, for: .normal)
                }
                maximumLabel.text = nil
            } else {
                maximumRankButton.setTitle(object.mx4Rank, for: .normal)
                maximumRateButton.setTitle(object.mx4Rate, for: .normal)
                maximumNoteButton.setTitle(object.mx4Note.noteAbbreviation, for: .normal)
                maximumLabel.text = "\(object.mx4)"
            }
        case Buttons.button5:
            top50Results = RecordInfo.get().sorted(byKeyPath: Skill.button5SkillPoint, ascending: false)
            guard let filtered = top50Results.filter(query).first else { return }
            guard let index = self.top50Results.index(of: filtered) else { return }
            if index < 50 {
                self.rankLabel.text = "#\(index + 1)"
            } else {
                self.rankLabel.text = "Out of Rank".localized
            }
            skillPointLabel.text = "\(object.button5SkillPoint) " + "Point".localized
            if object.nm5 == 0 {
                for button in normalButtons {
                    button?.isEnabled = false
                    button?.setTitle("None".localized, for: .normal)
                }
                normalLabel.text = nil
            } else {
                normalRankButton.setTitle(object.nm5Rank, for: .normal)
                normalRateButton.setTitle(object.nm5Rate, for: .normal)
                normalNoteButton.setTitle(object.nm5Note.noteAbbreviation, for: .normal)
                normalLabel.text = "\(object.nm5)"
            }
            if object.hd5 == 0 {
                for button in hardButtons {
                    button?.isEnabled = false
                    button?.setTitle("None".localized, for: .normal)
                }
                hardLabel.text = nil
            } else {
                hardRankButton.setTitle(object.hd5Rank, for: .normal)
                hardRateButton.setTitle(object.hd5Rate, for: .normal)
                hardNoteButton.setTitle(object.hd5Note.noteAbbreviation, for: .normal)
                hardLabel.text = "\(object.hd5)"
            }
            if object.mx5 == 0 {
                for button in maximumButtons {
                    button?.isEnabled = false
                    button?.setTitle("None".localized, for: .normal)
                }
                maximumLabel.text = nil
            } else {
                maximumRankButton.setTitle(object.mx5Rank, for: .normal)
                maximumRateButton.setTitle(object.mx5Rate, for: .normal)
                maximumNoteButton.setTitle(object.mx5Note.noteAbbreviation, for: .normal)
                maximumLabel.text = "\(object.mx5)"
            }
        case Buttons.button6:
            top50Results = RecordInfo.get().sorted(byKeyPath: Skill.button6SkillPoint, ascending: false)
            guard let filtered = top50Results.filter(query).first else { return }
            guard let index = self.top50Results.index(of: filtered) else { return }
            if index < 50 {
                self.rankLabel.text = "#\(index + 1)"
            } else {
                self.rankLabel.text = "Out of Rank".localized
            }
            skillPointLabel.text = "\(object.button6SkillPoint) " + "Point".localized
            if object.nm6 == 0 {
                for button in normalButtons {
                    button?.isEnabled = false
                    button?.setTitle("None".localized, for: .normal)
                }
                normalLabel.text = nil
            } else {
                normalRankButton.setTitle(object.nm6Rank, for: .normal)
                normalRateButton.setTitle(object.nm6Rate, for: .normal)
                normalNoteButton.setTitle(object.nm6Note.noteAbbreviation, for: .normal)
                normalLabel.text = "\(object.nm6)"
            }
            if object.hd6 == 0 {
                for button in hardButtons {
                    button?.isEnabled = false
                    button?.setTitle("None".localized, for: .normal)
                }
                hardLabel.text = nil
            } else {
                hardRankButton.setTitle(object.hd6Rank, for: .normal)
                hardRateButton.setTitle(object.hd6Rate, for: .normal)
                hardNoteButton.setTitle(object.hd6Note.noteAbbreviation, for: .normal)
                hardLabel.text = "\(object.hd6)"
            }
            if object.mx6 == 0 {
                for button in maximumButtons {
                    button?.isEnabled = false
                    button?.setTitle("None".localized, for: .normal)
                }
                maximumLabel.text = nil
            } else {
                maximumRankButton.setTitle(object.mx6Rank, for: .normal)
                maximumRateButton.setTitle(object.mx6Rate, for: .normal)
                maximumNoteButton.setTitle(object.mx6Note.noteAbbreviation, for: .normal)
                maximumLabel.text = "\(object.mx6)"
            }
        case Buttons.button8:
            top50Results = RecordInfo.get().sorted(byKeyPath: Skill.button8SkillPoint, ascending: false)
            guard let filtered = top50Results.filter(query).first else { return }
            guard let index = self.top50Results.index(of: filtered) else { return }
            if index < 50 {
                self.rankLabel.text = "#\(index + 1)"
            } else {
                self.rankLabel.text = "Out of Rank".localized
            }
            skillPointLabel.text = "\(object.button8SkillPoint) " + "Point".localized
            if object.nm8 == 0 {
                for button in normalButtons {
                    button?.isEnabled = false
                    button?.setTitle("None".localized, for: .normal)
                }
                normalLabel.text = nil
            } else {
                normalRankButton.setTitle(object.nm8Rank, for: .normal)
                normalRateButton.setTitle(object.nm8Rate, for: .normal)
                normalNoteButton.setTitle(object.nm8Note.noteAbbreviation, for: .normal)
                normalLabel.text = "\(object.nm8)"
            }
            if object.hd8 == 0 {
                for button in hardButtons {
                    button?.isEnabled = false
                    button?.setTitle("None".localized, for: .normal)
                }
                hardLabel.text = nil
            } else {
                hardRankButton.setTitle(object.hd8Rank, for: .normal)
                hardRateButton.setTitle(object.hd8Rate, for: .normal)
                hardNoteButton.setTitle(object.hd8Note.noteAbbreviation, for: .normal)
                hardLabel.text = "\(object.hd8)"
            }
            if object.mx8 == 0 {
                for button in maximumButtons {
                    button?.isEnabled = false
                    button?.setTitle("None".localized, for: .normal)
                }
                maximumLabel.text = nil
            } else {
                maximumRankButton.setTitle(object.mx8Rank, for: .normal)
                maximumRateButton.setTitle(object.mx8Rate, for: .normal)
                maximumNoteButton.setTitle(object.mx8Note.noteAbbreviation, for: .normal)
                maximumLabel.text = "\(object.mx8)"
            }
        default:
            break
        }
    }
}
