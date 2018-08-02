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
    func presentRankAlert()
    func presentRateAlert()
    func presentNoteAlert()
}

class RecordView: UIView {

    var delegate: RecordViewDelegate?
    var realm: Realm!
    var results: Results<RecordInfo>!
    var query: NSPredicate!
    var object: RecordInfo!
    var top50Results: Results<RecordInfo>!
    
    static var tableViewController: UITableViewController! = nil
    static var title: String = ""
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
        realm = try! Realm()
        results = realm.objects(RecordInfo.self)
        let favoriteButton = UserDefaults.standard.string(forKey: "favoriteButton") ?? "4B"
        cancelButton.setTitle("Cancel".localized, for: .normal)
        typeButton.setTitle(favoriteButton, for: .normal)
        titleLabel.text = RecordView.title
        query = NSPredicate(format: "title = %@", RecordView.title)
        object = results.filter(query).first!
        reloadButtonsAndLabels(button: favoriteButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.borderWidth = 3
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.mainColor.cgColor
    }
    
    class func instanceFromXib(title: String, tableViewController: UITableViewController) -> UIView{
        self.title = title
        self.tableViewController = tableViewController
        return UINib(nibName: "RecordView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! UIView
    }
    
    @IBAction func touchUpTypeButton(_ sender: UIButton) {
        switch((sender.titleLabel?.text)!){
        case "4B":
            typeButton.setTitle("5B", for: .normal)
            reloadButtonsAndLabels(button: "5B")
        case "5B":
            typeButton.setTitle("6B", for: .normal)
            reloadButtonsAndLabels(button: "6B")
        case "6B":
            typeButton.setTitle("8B", for: .normal)
            reloadButtonsAndLabels(button: "8B")
        case "8B":
            typeButton.setTitle("4B", for: .normal)
            reloadButtonsAndLabels(button: "4B")
        default:
            break
        }
    }
    
    @IBAction func touchUpOtherButtons(_ sender: UIButton) {
        let button = (typeButton.titleLabel?.text!)!
        switch(sender.tag){
        case 0:
            showRankAlert(difficulty: .normal, button: button)
        case 1:
            showRateAlert(difficulty: .normal, button: button)
        case 2:
            showNoteAlert(difficulty: .normal, button: button)
        case 3:
            showRankAlert(difficulty: .hard, button: button)
        case 4:
            showRateAlert(difficulty: .hard, button: button)
        case 5:
            showNoteAlert(difficulty: .hard, button: button)
        case 6:
            showRankAlert(difficulty: .maximum, button: button)
        case 7:
            showRateAlert(difficulty: .maximum, button: button)
        case 8:
            showNoteAlert(difficulty: .maximum, button: button)
        default:
            break
        }
    }
    
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        let tableViewController = RecordView.tableViewController
        let parentViewController = tableViewController?.parent as! RecordViewController
        if(parentViewController.view.subviews.last is RecordView){
            parentViewController.scrollView.frame.size.height += 200
            self.removeFromSuperview()
        }
        if let selectedRow = tableViewController?.tableView.indexPathForSelectedRow {
            tableViewController?.tableView.deselectRow(at: selectedRow, animated: false)
        }
    }
    
    func showRankAlert(difficulty: Difficulty, button: String) {
        delegate?.presentRankAlert()
        let alert = UIAlertController(title: "Rank".localized, message: "Select your rank.".localized, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel".localized, style: .cancel)
        let initialize = UIAlertAction(title: "-", style: .default) { _ in
            self.setRank(rank: nil, difficulty: difficulty, button: button)
            self.reloadButtonsAndLabels(button: button)
        }
        let s = UIAlertAction(title: "S", style: .default) { _ in
            self.setRank(rank: "S", difficulty: difficulty, button: button)
            self.reloadButtonsAndLabels(button: button)
        }
        let a = UIAlertAction(title: "A", style: .default) { _ in
            self.setRank(rank: "A", difficulty: difficulty, button: button)
            self.reloadButtonsAndLabels(button: button)
        }
        let b = UIAlertAction(title: "B", style: .default) { _ in
            self.setRank(rank: "B", difficulty: difficulty, button: button)
            self.reloadButtonsAndLabels(button: button)
        }
        let c = UIAlertAction(title: "C", style: .default) { _ in
            self.setRank(rank: "C", difficulty: difficulty, button: button)
            self.reloadButtonsAndLabels(button: button)
        }
        alert.addAction(cancel)
        alert.addAction(initialize)
        alert.addAction(s)
        alert.addAction(a)
        alert.addAction(b)
        alert.addAction(c)
        RecordView.tableViewController.present(alert, animated: true, completion: nil)
    }
    func showRateAlert(difficulty: Difficulty, button: String) {
        delegate?.presentRateAlert()
        let alert = UIAlertController(title: "Rate".localized, message: "Input your rate.\nTo reset the value, do not enter any values.".localized, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.keyboardType = .decimalPad
            textField.placeholder = "Rate".localized
        }
        let cancel = UIAlertAction(title: "Cancel".localized, style: .cancel)
        let yes = UIAlertAction(title: "OK".localized, style: .default) { _ in
            if let input = alert.textFields?.first?.text {
                if(input.isEmpty){
                    self.setRate(rate: nil, difficulty: difficulty, button: button)
                    self.reloadButtonsAndLabels(button: button)
                } else {
                    let inputDouble = Double(input)!
                    let rate: String = inputDouble >= 100 ? String(100.00) : input
                    self.setRate(rate: rate, difficulty: difficulty, button: button)
                    switch(inputDouble){
                    case 98...100:
                        self.setRank(rank: "S", difficulty: difficulty, button: button)
                    case 95..<98:
                        self.setRank(rank: "A", difficulty: difficulty, button: button)
                    case 90..<95:
                        self.setRank(rank: "B", difficulty: difficulty, button: button)
                    case 0..<90:
                        self.setRank(rank: "C", difficulty: difficulty, button: button)
                    default:
                        break
                    }
                    self.reloadButtonsAndLabels(button: button)
                    switch(button){
                    case "4B":
                        switch(difficulty){
                        case .normal:
                            if(!(self.object.nm4Note == "MAX COMBO")){
                                self.showNoteAlert(difficulty: difficulty, button: button)
                            }
                        case .hard:
                            if(!(self.object.hd4Note == "MAX COMBO")){
                                self.showNoteAlert(difficulty: difficulty, button: button)
                            }
                        case .maximum:
                            if(!(self.object.mx4Note == "MAX COMBO")){
                                self.showNoteAlert(difficulty: difficulty, button: button)
                            }
                        }
                    case "5B":
                        switch(difficulty){
                        case .normal:
                            if(!(self.object.nm5Note == "MAX COMBO")){
                                self.showNoteAlert(difficulty: difficulty, button: button)
                            }
                        case .hard:
                            if(!(self.object.hd5Note == "MAX COMBO")){
                                self.showNoteAlert(difficulty: difficulty, button: button)
                            }
                        case .maximum:
                            if(!(self.object.mx5Note == "MAX COMBO")){
                                self.showNoteAlert(difficulty: difficulty, button: button)
                            }
                        }
                    case "6B":
                        switch(difficulty){
                        case .normal:
                            if(!(self.object.nm6Note == "MAX COMBO")){
                                self.showNoteAlert(difficulty: difficulty, button: button)
                            }
                        case .hard:
                            if(!(self.object.hd6Note == "MAX COMBO")){
                                self.showNoteAlert(difficulty: difficulty, button: button)
                            }
                        case .maximum:
                            if(!(self.object.mx6Note == "MAX COMBO")){
                                self.showNoteAlert(difficulty: difficulty, button: button)
                            }
                        }
                    case "8B":
                        switch(difficulty){
                        case .normal:
                            if(!(self.self.object.nm8Note == "MAX COMBO")){
                                self.showNoteAlert(difficulty: difficulty, button: button)
                            }
                        case .hard:
                            if(!(self.object.hd8Note == "MAX COMBO")){
                                self.showNoteAlert(difficulty: difficulty, button: button)
                            }
                        case .maximum:
                            if(!(self.object.mx8Note == "MAX COMBO")){
                                self.showNoteAlert(difficulty: difficulty, button: button)
                            }
                        }
                    default:
                        break
                    }
                }
            }
        }
        alert.addAction(cancel)
        alert.addAction(yes)
        RecordView.tableViewController.present(alert, animated: true, completion: nil)
    }
    
    func showNoteAlert(difficulty: Difficulty, button: String) {
        delegate?.presentNoteAlert()
        let alert = UIAlertController(title: "Note".localized, message: "Select your note.".localized, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel".localized, style: .cancel)
        let initialize = UIAlertAction(title: "-", style: .default) { _ in
            self.setNote(note: nil, difficulty: difficulty, button: button)
            self.reloadButtonsAndLabels(button: button)
        }
        let maxCombo = UIAlertAction(title: "MAX COMBO", style: .default) { _ in
            self.setNote(note: "MAX COMBO", difficulty: difficulty, button: button)
            self.reloadButtonsAndLabels(button: button)
        }
        let perfectPlay = UIAlertAction(title: "PERFECT PLAY", style: .default) { _ in
            self.setRate(rate: "100", difficulty: difficulty, button: button)
            self.setRank(rank: "S", difficulty: difficulty, button: button)
            self.setNote(note: "PERFECT PLAY", difficulty: difficulty, button: button)
            self.reloadButtonsAndLabels(button: button)
        }
        alert.addAction(cancel)
        alert.addAction(initialize)
        alert.addAction(maxCombo)
        alert.addAction(perfectPlay)
        RecordView.tableViewController.present(alert, animated: true, completion: nil)
    }
    func setRank(rank: String?, difficulty: Difficulty, button: String) {
        switch(button){
        case "4B":
            try! realm.write {
                switch(difficulty){
                case .normal:
                    object.nm4Rank = rank ?? "-"
                case .hard:
                    object.hd4Rank = rank ?? "-"
                case .maximum:
                    object.mx4Rank = rank ?? "-"
                }
            }
        case "5B":
            try! realm.write {
                switch(difficulty){
                case .normal:
                    object.nm5Rank = rank ?? "-"
                case .hard:
                    object.hd5Rank = rank ?? "-"
                case .maximum:
                    object.mx5Rank = rank ?? "-"
                }
            }
        case "6B":
            try! realm.write {
                switch(difficulty){
                case .normal:
                    object.nm6Rank = rank ?? "-"
                case .hard:
                    object.hd6Rank = rank ?? "-"
                case .maximum:
                    object.mx6Rank = rank ?? "-"
                }
            }
        case "8B":
            try! realm.write {
                switch(difficulty){
                case .normal:
                    object.nm8Rank = rank ?? "-"
                case .hard:
                    object.hd8Rank = rank ?? "-"
                case .maximum:
                    object.mx8Rank = rank ?? "-"
                }
            }
        default:
            break
        }
    }
    
    func setRate(rate: String?, difficulty: Difficulty, button: String) {
        let title = RecordView.title
        let query = NSPredicate(format: "title = %@", title)
        let object = results.filter(query).first!
        var value: String? = nil
        if let temp = rate{
            value = String(format: "%05.2f%%", Double(temp)!)
        }
        switch(button){
        case "4B":
            try! realm.write{
                switch(difficulty){
                case .normal:
                    object.nm4Rate = value ?? "-"
                case .hard:
                    object.hd4Rate = value ?? "-"
                case .maximum:
                    object.mx4Rate = value ?? "-"
                }
            }
            setSkillPoint(button: button)
            showSkillPoint(sender: 0)
        case "5B":
            try! realm.write{
                switch(difficulty){
                case .normal:
                    object.nm5Rate = value ?? "-"
                case .hard:
                    object.hd5Rate = value ?? "-"
                case .maximum:
                    object.mx5Rate = value ?? "-"
                }
            }
            setSkillPoint(button: button)
            showSkillPoint(sender: 1)
        case "6B":
            try! realm.write{
                switch(difficulty){
                case .normal:
                    object.nm6Rate = value ?? "-"
                case .hard:
                    object.hd6Rate = value ?? "-"
                case .maximum:
                    object.mx6Rate = value ?? "-"
                }
            }
            setSkillPoint(button: button)
            showSkillPoint(sender: 2)
        case "8B":
            try! realm.write{
                switch(difficulty){
                case .normal:
                    object.nm8Rate = value ?? "-"
                case .hard:
                    object.hd8Rate = value ?? "-"
                case .maximum:
                    object.mx8Rate = value ?? "-"
                }
            }
            setSkillPoint(button: button)
            showSkillPoint(sender: 3)
        default:
            break
        }
    }
    func setNote(note: String?, difficulty: Difficulty, button: String) {
        switch(button){
        case "4B":
            try! realm.write{
                switch(difficulty){
                case .normal:
                    object.nm4Note = note ?? "-"
                case .hard:
                    object.hd4Note = note ?? "-"
                case .maximum:
                    object.mx4Note = note ?? "-"
                }
            }
            setSkillPoint(button: button)
            showSkillPoint(sender: 0)
        case "5B":
            try! realm.write{
                switch(difficulty){
                case .normal:
                    object.nm5Note = note ?? "-"
                case .hard:
                    object.hd5Note = note ?? "-"
                case .maximum:
                    object.mx5Note = note ?? "-"
                }
            }
            setSkillPoint(button: button)
            showSkillPoint(sender: 1)
        case "6B":
            try! realm.write{
                switch(difficulty){
                case .normal:
                    object.nm6Note = note ?? "-"
                case .hard:
                    object.hd6Note = note ?? "-"
                case .maximum:
                    object.mx6Note = note ?? "-"
                }
            }
            setSkillPoint(button: button)
            showSkillPoint(sender: 2)
        case "8B":
            try! realm.write{
                switch(difficulty){
                case .normal:
                    object.nm8Note = note ?? "-"
                case .hard:
                    object.hd8Note = note ?? "-"
                case .maximum:
                    object.mx8Note = note ?? "-"
                }
            }
            setSkillPoint(button: button)
            showSkillPoint(sender: 3)
        default:
            break
        }
    }
    
    func showSkillPoint(sender: Int){
        switch(sender){
        case 0:
            skillPointLabel.text = "\(object.button4SkillPoint) " + "Point".localized
            top50Results = realm.objects(RecordInfo.self).sorted(byKeyPath: "button4SkillPoint", ascending: false)
            let index: Int = top50Results.index(of: top50Results.filter(query).first!)!
            if(index < 50){
                rankLabel.text = "#\(index + 1)"
            } else {
                rankLabel.text = "Out of Rank".localized
            }
        case 1:
            skillPointLabel.text = "\(object.button5SkillPoint) " + "Point".localized
            top50Results = realm.objects(RecordInfo.self).sorted(byKeyPath: "button5SkillPoint", ascending: false)
            let index: Int = top50Results.index(of: top50Results.filter(query).first!)!
            if(index < 50){
                rankLabel.text = "#\(index + 1)"
            } else {
                rankLabel.text = "Out of Rank".localized
            }
        case 2:
            skillPointLabel.text = "\(object.button6SkillPoint) " + "Point".localized
            top50Results = realm.objects(RecordInfo.self).sorted(byKeyPath: "button6SkillPoint", ascending: false)
            let index: Int = top50Results.index(of: top50Results.filter(query).first!)!
            if(index < 50){
                rankLabel.text = "#\(index + 1)"
            } else {
                rankLabel.text = "Out of Rank".localized
            }
        case 3:
            skillPointLabel.text = "\(object.button8SkillPoint) " + "Point".localized
            top50Results = realm.objects(RecordInfo.self).sorted(byKeyPath: "button8SkillPoint", ascending: false)
            let index: Int = top50Results.index(of: top50Results.filter(query).first!)!
            if(index < 50){
                rankLabel.text = "#\(index + 1)"
            } else {
                rankLabel.text = "Out of Rank".localized
            }
        default:
            break
        }
    }
    
    func setSkillPoint(button: String) {
        switch(button){
        case "4B":
            let nm4Point = getSkillPoint(difficulty: object.nm4, rate: object.nm4Rate, note: object.nm4Note)
            let hd4Point = getSkillPoint(difficulty: object.hd4, rate: object.hd4Rate, note: object.hd4Note)
            let mx4Point = getSkillPoint(difficulty: object.mx4, rate: object.mx4Rate, note: object.mx4Note)
            let max4Point = [nm4Point, hd4Point, mx4Point].sorted()[2]
            try! realm.write{
                object.button4SkillPoint = max4Point
                switch(max4Point){
                case nm4Point:
                    object.button4HighestSkillPointDifficulty = "NORMAL"
                    object.button4HighestSkillPointRate = (object.nm4Rate)
                    object.button4HighestSkillPointNote = (object.nm4Note)
                case hd4Point:
                    object.button4HighestSkillPointDifficulty = "HARD"
                    object.button4HighestSkillPointRate = (object.hd4Rate)
                    object.button4HighestSkillPointNote = (object.hd4Note)
                case mx4Point:
                    object.button4HighestSkillPointDifficulty = "MAXIMUM"
                    object.button4HighestSkillPointRate = (object.mx4Rate)
                    object.button4HighestSkillPointNote = (object.mx4Note)
                default:
                    break
                }
            }
        case "5B":
            let nm5Point = getSkillPoint(difficulty: object.nm5, rate: object.nm5Rate, note: object.nm5Note)
            let hd5Point = getSkillPoint(difficulty: object.hd5, rate: object.hd5Rate, note: object.hd5Note)
            let mx5Point = getSkillPoint(difficulty: object.mx5, rate: object.mx5Rate, note: object.mx5Note)
            let max5Point = [nm5Point, hd5Point, mx5Point].sorted()[2]
            try! realm.write{
                object.button5SkillPoint = max5Point
                switch(max5Point){
                case nm5Point:
                    object.button5HighestSkillPointDifficulty = "NORMAL"
                    object.button5HighestSkillPointRate = (object.nm5Rate)
                    object.button5HighestSkillPointNote = (object.nm5Note)
                case hd5Point:
                    object.button5HighestSkillPointDifficulty = "HARD"
                    object.button5HighestSkillPointRate = (object.hd5Rate)
                    object.button5HighestSkillPointNote = (object.hd5Note)
                case mx5Point:
                    object.button5HighestSkillPointDifficulty = "MAXIMUM"
                    object.button5HighestSkillPointRate = (object.mx5Rate)
                    object.button5HighestSkillPointNote = (object.mx5Note)
                default:
                    break
                }
            }
        case "6B":
            let nm6Point = getSkillPoint(difficulty: object.nm6, rate: object.nm6Rate, note: object.nm6Note)
            let hd6Point = getSkillPoint(difficulty: object.hd6, rate: object.hd6Rate, note: object.hd6Note)
            let mx6Point = getSkillPoint(difficulty: object.mx6, rate: object.mx6Rate, note: object.mx6Note)
            let max6Point = [nm6Point, hd6Point, mx6Point].sorted()[2]
            try! realm.write{
                object.button6SkillPoint = max6Point
                switch(max6Point){
                case nm6Point:
                    object.button6HighestSkillPointDifficulty = "NORMAL"
                    object.button6HighestSkillPointRate = (object.nm6Rate)
                    object.button6HighestSkillPointNote = (object.nm6Note)
                case hd6Point:
                    object.button6HighestSkillPointDifficulty = "HARD"
                    object.button6HighestSkillPointRate = (object.hd6Rate)
                    object.button6HighestSkillPointNote = (object.hd6Note)
                case mx6Point:
                    object.button6HighestSkillPointDifficulty = "MAXIMUM"
                    object.button6HighestSkillPointRate = (object.mx6Rate)
                    object.button6HighestSkillPointNote = (object.mx6Note)
                default:
                    break
                }
            }
        case "8B":
            let nm8Point = getSkillPoint(difficulty: object.nm8, rate: object.nm8Rate, note: object.nm8Note)
            let hd8Point = getSkillPoint(difficulty: object.hd8, rate: object.hd8Rate, note: object.hd8Note)
            let mx8Point = getSkillPoint(difficulty: object.mx8, rate: object.mx8Rate, note: object.mx8Note)
            let max8Point = [nm8Point, hd8Point, mx8Point].sorted()[2]
            try! realm.write{
                object.button8SkillPoint = max8Point
                switch(max8Point){
                case nm8Point:
                    object.button8HighestSkillPointDifficulty = "NORMAL"
                    object.button8HighestSkillPointRate = (object.nm8Rate)
                    object.button8HighestSkillPointNote = (object.nm8Note)
                case hd8Point:
                    object.button8HighestSkillPointDifficulty = "HARD"
                    object.button8HighestSkillPointRate = (object.hd8Rate)
                    object.button8HighestSkillPointNote = (object.hd8Note)
                case mx8Point:
                    object.button8HighestSkillPointDifficulty = "MAXIMUM"
                    object.button8HighestSkillPointRate = (object.mx8Rate)
                    object.button8HighestSkillPointNote = (object.mx8Note)
                default:
                    break
                }
            }
        default:
            break
        }
    }
    
    func makeNoteText(note: String) -> String {
        if(note == "-"){
            return "-"
        } else if(note == "MAX COMBO"){
            return "MC"
        } else if(note == "PERFECT PLAY"){
            return "PP"
        } else{
            return "-1"
        }
    }
    
    func reloadButtonsAndLabels(button: String) {
        normalRankButton.isEnabled = true
        normalRateButton.isEnabled = true
        normalNoteButton.isEnabled = true
        hardRankButton.isEnabled = true
        hardRateButton.isEnabled = true
        hardNoteButton.isEnabled = true
        maximumRankButton.isEnabled = true
        maximumRateButton.isEnabled = true
        maximumNoteButton.isEnabled = true
        let title = RecordView.title
        let query = NSPredicate(format: "title = %@", title)
        let object = results.filter(query).first!
        switch(button){
        case "4B":
            top50Results = realm.objects(RecordInfo.self).sorted(byKeyPath: "button4SkillPoint", ascending: false)
            let index: Int = top50Results.index(of: top50Results.filter(query).first!)!
            if(index < 50){
                rankLabel.text = "#\(index + 1)"
            } else {
                rankLabel.text = "Out of Rank".localized
            }
            skillPointLabel.text = "\(object.button4SkillPoint) " + "Point".localized
            if(object.nm4 == 0){
                normalRankButton.isEnabled = false
                normalRateButton.isEnabled = false
                normalNoteButton.isEnabled = false
                normalRankButton.setTitle("None".localized, for: .normal)
                normalRateButton.setTitle("None".localized, for: .normal)
                normalNoteButton.setTitle("None".localized, for: .normal)
                normalLabel.text = nil
            } else {
                normalRankButton.setTitle(object.nm4Rank, for: .normal)
                normalRateButton.setTitle(object.nm4Rate, for: .normal)
                normalNoteButton.setTitle(makeNoteText(note: object.nm4Note), for: .normal)
                normalLabel.text = String(object.nm4)
            }
            if(object.hd4 == 0){
                hardRankButton.isEnabled = false
                hardRateButton.isEnabled = false
                hardNoteButton.isEnabled = false
                hardRankButton.setTitle("None".localized, for: .normal)
                hardRateButton.setTitle("None".localized, for: .normal)
                hardNoteButton.setTitle("None".localized, for: .normal)
                hardLabel.text = nil
            } else {
                hardRankButton.setTitle(object.hd4Rank, for: .normal)
                hardRateButton.setTitle(object.hd4Rate, for: .normal)
                hardNoteButton.setTitle(makeNoteText(note: object.hd4Note), for: .normal)
                hardLabel.text = String(object.hd4)
            }
            if(object.mx4 == 0){
                maximumRankButton.isEnabled = false
                maximumRateButton.isEnabled = false
                maximumNoteButton.isEnabled = false
                maximumRankButton.setTitle("None".localized, for: .normal)
                maximumRateButton.setTitle("None".localized, for: .normal)
                maximumNoteButton.setTitle("None".localized, for: .normal)
                maximumLabel.text = nil
            } else {
                maximumRankButton.setTitle(object.mx4Rank, for: .normal)
                maximumRateButton.setTitle(object.mx4Rate, for: .normal)
                maximumNoteButton.setTitle(makeNoteText(note: object.mx4Note), for: .normal)
                maximumLabel.text = String(object.mx4)
            }
        case "5B":
            top50Results = realm.objects(RecordInfo.self).sorted(byKeyPath: "button5SkillPoint", ascending: false)
            let index: Int = top50Results.index(of: top50Results.filter(query).first!)!
            if(index < 50){
                rankLabel.text = "#\(index + 1)"
            } else {
                rankLabel.text = "Out of Rank".localized
            }
            skillPointLabel.text = "\(object.button5SkillPoint) " + "Point".localized
            if(object.nm5 == 0){
                normalRankButton.isEnabled = false
                normalRateButton.isEnabled = false
                normalNoteButton.isEnabled = false
                normalRankButton.setTitle("None".localized, for: .normal)
                normalRateButton.setTitle("None".localized, for: .normal)
                normalNoteButton.setTitle("None".localized, for: .normal)
                normalLabel.text = nil
            } else {
                normalRankButton.setTitle(object.nm5Rank, for: .normal)
                normalRateButton.setTitle(object.nm5Rate, for: .normal)
                normalNoteButton.setTitle(makeNoteText(note: object.nm5Note), for: .normal)
                normalLabel.text = String(object.nm5)
            }
            if(object.hd5 == 0){
                hardRankButton.isEnabled = false
                hardRateButton.isEnabled = false
                hardNoteButton.isEnabled = false
                hardRankButton.setTitle("None".localized, for: .normal)
                hardRateButton.setTitle("None".localized, for: .normal)
                hardNoteButton.setTitle("None".localized, for: .normal)
                hardLabel.text = nil
            } else {
                hardRankButton.setTitle(object.hd5Rank, for: .normal)
                hardRateButton.setTitle(object.hd5Rate, for: .normal)
                hardNoteButton.setTitle(makeNoteText(note: object.hd5Note), for: .normal)
                hardLabel.text = String(object.hd5)
            }
            if(object.mx5 == 0){
                maximumRankButton.isEnabled = false
                maximumRateButton.isEnabled = false
                maximumNoteButton.isEnabled = false
                maximumRankButton.setTitle("None".localized, for: .normal)
                maximumRateButton.setTitle("None".localized, for: .normal)
                maximumNoteButton.setTitle("None".localized, for: .normal)
                maximumLabel.text = nil
            } else {
                maximumRankButton.setTitle(object.mx5Rank, for: .normal)
                maximumRateButton.setTitle(object.mx5Rate, for: .normal)
                maximumNoteButton.setTitle(makeNoteText(note: object.mx5Note), for: .normal)
                maximumLabel.text = String(object.mx5)
            }
        case "6B":
            top50Results = realm.objects(RecordInfo.self).sorted(byKeyPath: "button6SkillPoint", ascending: false)
            let index: Int = top50Results.index(of: top50Results.filter(query).first!)!
            if(index < 50){
                rankLabel.text = "#\(index + 1)"
            } else {
                rankLabel.text = "Out of Rank".localized
            }
            skillPointLabel.text = "\(object.button6SkillPoint) " + "Point".localized
            if(object.nm6 == 0){
                normalRankButton.isEnabled = false
                normalRateButton.isEnabled = false
                normalNoteButton.isEnabled = false
                normalRankButton.setTitle("None".localized, for: .normal)
                normalRateButton.setTitle("None".localized, for: .normal)
                normalNoteButton.setTitle("None".localized, for: .normal)
                normalLabel.text = nil
            } else {
                normalRankButton.setTitle(object.nm6Rank, for: .normal)
                normalRateButton.setTitle(object.nm6Rate, for: .normal)
                normalNoteButton.setTitle(makeNoteText(note: object.nm6Note), for: .normal)
                normalLabel.text = String(object.nm6)
            }
            if(object.hd6 == 0){
                hardRankButton.isEnabled = false
                hardRateButton.isEnabled = false
                hardNoteButton.isEnabled = false
                hardRankButton.setTitle("None".localized, for: .normal)
                hardRateButton.setTitle("None".localized, for: .normal)
                hardNoteButton.setTitle("None".localized, for: .normal)
                hardLabel.text = nil
            } else {
                hardRankButton.setTitle(object.hd6Rank, for: .normal)
                hardRateButton.setTitle(object.hd6Rate, for: .normal)
                hardNoteButton.setTitle(makeNoteText(note: object.hd6Note), for: .normal)
                hardLabel.text = String(object.hd6)
            }
            if(object.mx6 == 0){
                maximumRankButton.isEnabled = false
                maximumRateButton.isEnabled = false
                maximumNoteButton.isEnabled = false
                maximumRankButton.setTitle("None".localized, for: .normal)
                maximumRateButton.setTitle("None".localized, for: .normal)
                maximumNoteButton.setTitle("None".localized, for: .normal)
                maximumLabel.text = nil
            } else {
                maximumRankButton.setTitle(object.mx6Rank, for: .normal)
                maximumRateButton.setTitle(object.mx6Rate, for: .normal)
                maximumNoteButton.setTitle(makeNoteText(note: object.mx6Note), for: .normal)
                maximumLabel.text = String(object.mx6)
            }
        case "8B":
            top50Results = realm.objects(RecordInfo.self).sorted(byKeyPath: "button8SkillPoint", ascending: false)
            let index: Int = top50Results.index(of: top50Results.filter(query).first!)!
            if(index < 50){
                rankLabel.text = "#\(index + 1)"
            } else {
                rankLabel.text = "Out of Rank".localized
            }
            skillPointLabel.text = "\(object.button8SkillPoint) " + "Point".localized
            if(object.nm8 == 0){
                normalRankButton.isEnabled = false
                normalRateButton.isEnabled = false
                normalNoteButton.isEnabled = false
                normalRankButton.setTitle("None".localized, for: .normal)
                normalRateButton.setTitle("None".localized, for: .normal)
                normalNoteButton.setTitle("None".localized, for: .normal)
                normalLabel.text = nil
            } else {
                normalRankButton.setTitle(object.nm8Rank, for: .normal)
                normalRateButton.setTitle(object.nm8Rate, for: .normal)
                normalNoteButton.setTitle(makeNoteText(note: object.nm8Note), for: .normal)
                normalLabel.text = String(object.nm8)
            }
            if(object.hd8 == 0){
                hardRankButton.isEnabled = false
                hardRateButton.isEnabled = false
                hardNoteButton.isEnabled = false
                hardRankButton.setTitle("None".localized, for: .normal)
                hardRateButton.setTitle("None".localized, for: .normal)
                hardNoteButton.setTitle("None".localized, for: .normal)
                hardLabel.text = nil
            } else {
                hardRankButton.setTitle(object.hd8Rank, for: .normal)
                hardRateButton.setTitle(object.hd8Rate, for: .normal)
                hardNoteButton.setTitle(makeNoteText(note: object.hd8Note), for: .normal)
                hardLabel.text = String(object.hd8)
            }
            if(object.mx8 == 0){
                maximumRankButton.isEnabled = false
                maximumRateButton.isEnabled = false
                maximumNoteButton.isEnabled = false
                maximumRankButton.setTitle("None".localized, for: .normal)
                maximumRateButton.setTitle("None".localized, for: .normal)
                maximumNoteButton.setTitle("None".localized, for: .normal)
                maximumLabel.text = nil
            } else {
                maximumRankButton.setTitle(object.mx8Rank, for: .normal)
                maximumRateButton.setTitle(object.mx8Rate, for: .normal)
                maximumNoteButton.setTitle(makeNoteText(note: object.mx8Note), for: .normal)
                maximumLabel.text = String(object.mx8)
            }
        default:
            break
        }
    }
}
