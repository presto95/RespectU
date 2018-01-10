//
//  SongDetailViewController.swift
//  RespectU
//
//  Created by Presto on 2017. 10. 29..
//  Copyright © 2017년 Presto. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import NotificationBannerSwift
import RealmSwift

class SongDetailViewController: UIViewController {

    let realm = try! Realm()
    var key: String=""
    var detailBpm: String=""
    var detailTitle: String=""
    var detailSeries: String=""
    var is4BNormalExist: Bool = true
    var is4BHardExist: Bool = true
    var is4BMaximumExist: Bool = true
    var is5BNormalExist: Bool = true
    var is5BHardExist: Bool = true
    var is5BMaximumExist: Bool = true
    var is6BNormalExist: Bool = true
    var is6BHardExist: Bool = true
    var is6BMaximumExist: Bool = true
    var is8BNormalExist: Bool = true
    var is8BHardExist: Bool = true
    var is8BMaximumExist: Bool = true
    var nm4: Int=0
    var nm5: Int=0
    var nm6: Int=0
    var nm8: Int=0
    var hd4: Int=0
    var hd5: Int=0
    var hd6: Int=0
    var hd8: Int=0
    var mx4: Int=0
    var mx5: Int=0
    var mx6: Int=0
    var mx8: Int=0
    let BPM=UserDefaults.standard.double(forKey: "bpm")
    var query: NSPredicate? = nil
    var record: RecordInfo? = nil
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelBpm: UILabel!
    @IBOutlet weak var labelSeries: UILabel!
    @IBOutlet weak var labelSkillPoint: UILabel!
    @IBOutlet weak var buttonNormalRank: UIButton!
    @IBOutlet weak var buttonNormalAccuracy: UIButton!
    @IBOutlet weak var buttonNormalNote: UIButton!
    @IBOutlet weak var buttonHardRank: UIButton!
    @IBOutlet weak var buttonHardAccuracy: UIButton!
    @IBOutlet weak var buttonHardNote: UIButton!
    @IBOutlet weak var buttonMaximumRank: UIButton!
    @IBOutlet weak var buttonMaximumAccuracy: UIButton!
    @IBOutlet weak var buttonMaximumNote: UIButton!
    @IBOutlet weak var labelNormal: UILabel!
    @IBOutlet weak var labelNormalDifficulty: UILabel!
    @IBOutlet weak var labelHard: UILabel!
    @IBOutlet weak var labelHardDifficulty: UILabel!
    @IBOutlet weak var labelMaximum: UILabel!
    @IBOutlet weak var labelMaximumDifficulty: UILabel!
    @IBOutlet weak var labelRank: UILabel!
    @IBOutlet weak var labelAccuracy: UILabel!
    @IBOutlet weak var labelNote: UILabel!
    @IBOutlet weak var labelNormalColor: UILabel!
    @IBOutlet weak var labelHardColor: UILabel!
    @IBOutlet weak var labelMaximumColor: UILabel!
    
    /*
     키값 규칙 :
     [곡명][키][난이도(소문자)][항목(랭크 정확도 비고)]
     */
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch(key){
        case "4B":
            segmentedControl.selectedSegmentIndex = 0
        case "5B":
            segmentedControl.selectedSegmentIndex = 1
        case "6B":
            segmentedControl.selectedSegmentIndex = 2
        case "8B":
            segmentedControl.selectedSegmentIndex = 3
        default:
            break
        }
        query = NSPredicate(format: "title = %@",self.detailTitle)
        record = try! Realm().objects(RecordInfo.self).filter(query!).first!
        self.navigationItem.title = "Performance Record".localized
        labelRank.text = "RANK".localized
        labelAccuracy.text = "ACCURACY".localized
        labelNote.text = "NOTE".localized
        var recommend: String=""
        var recommendTransform: String=" "+"(SPEED Variation)".localized
        var bpm: Double=0.0
        let bpmCell="BPM "+detailBpm
        var strArr=bpmCell.split(separator: " ")
        if(strArr.contains("~")){
            bpm=Double(strArr[3])!
        }
        else{
            bpm=Double(strArr[1])!
            recommendTransform=""
        }
        let speed = BPM/bpm
        switch(speed){
        case ..<0.50: recommend="0.50"+recommendTransform
        case 0.50..<0.75: recommend="0.50 ~ 0.75"+recommendTransform
        case 0.75..<1.00: recommend="0.75 ~ 1.00"+recommendTransform
        case 1.00..<1.25: recommend="1.00 ~ 1.25"+recommendTransform
        case 1.25..<1.50: recommend="1.25 ~ 1.50"+recommendTransform
        case 1.50..<1.75: recommend="1.50 ~ 1.75"+recommendTransform
        case 1.75..<2.00: recommend="1.75 ~ 2.00"+recommendTransform
        case 2.00..<2.25: recommend="2.00 ~ 2.25"+recommendTransform
        case 2.25..<2.50: recommend="2.25 ~ 2.50"+recommendTransform
        case 2.50..<2.75: recommend="2.50 ~ 2.75"+recommendTransform
        case 2.75..<3.00: recommend="2.75 ~ 3.00"+recommendTransform
        case 3.00..<3.25: recommend="3.00 ~ 3.25"+recommendTransform
        case 3.25..<3.50: recommend="3.25 ~ 3.50"+recommendTransform
        case 3.50..<3.75: recommend="3.50 ~ 3.75"+recommendTransform
        case 3.75..<4.00: recommend="3.75 ~ 4.00"+recommendTransform
        case 4.00..<4.25: recommend="4.00 ~ 4.25"+recommendTransform
        case 4.25..<4.50: recommend="4.25 ~ 4.50"+recommendTransform
        case 4.50..<4.75: recommend="4.50 ~ 4.75"+recommendTransform
        case 4.75..<5.00: recommend="4.75 ~ 5.00"+recommendTransform
        case 5.00...: recommend="5.00"+recommendTransform
        default: break
        }
        labelBpm.text = "SPEED Recommendation".localized+" : "+recommend
        showDifficulty()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let isNight=UserDefaults.standard.bool(forKey: "night")
        tabBarController?.tabBar.barStyle = isNight ? .black : .default
        navigationController?.navigationBar.barStyle = isNight ? .black : .default
        view.backgroundColor=isNight ? UIColor(red: 0, green: 0, blue: 0, alpha: 1) : UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        labelNormalDifficulty.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelHardDifficulty.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelMaximumDifficulty.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelNormal.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelHard.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelMaximum.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelTitle.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelBpm.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelSkillPoint.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        buttonNormalRank.setTitleColor(UIColor(red: 145/255.0, green: 145/255.0, blue: 145/255.0, alpha: 1), for: .disabled)
        buttonNormalAccuracy.setTitleColor(UIColor(red: 145/255.0, green: 145/255.0, blue: 145/255.0, alpha: 1), for: .disabled)
        buttonNormalNote.setTitleColor(UIColor(red: 145/255.0, green: 145/255.0, blue: 145/255.0, alpha: 1), for: .disabled)
        buttonHardRank.setTitleColor(UIColor(red: 145/255.0, green: 145/255.0, blue: 145/255.0, alpha: 1), for: .disabled)
        buttonHardAccuracy.setTitleColor(UIColor(red: 145/255.0, green: 145/255.0, blue: 145/255.0, alpha: 1), for: .disabled)
        buttonHardNote.setTitleColor(UIColor(red: 145/255.0, green: 145/255.0, blue: 145/255.0, alpha: 1), for: .disabled)
        buttonMaximumRank.setTitleColor(UIColor(red: 145/255.0, green: 145/255.0, blue: 145/255.0, alpha: 1), for: .disabled)
        buttonMaximumAccuracy.setTitleColor(UIColor(red: 145/255.0, green: 145/255.0, blue: 145/255.0, alpha: 1), for: .disabled)
        buttonMaximumNote.setTitleColor(UIColor(red: 145/255.0, green: 145/255.0, blue: 145/255.0, alpha: 1), for: .disabled)
        labelTitle.text = detailTitle
        switch(detailSeries){
        case "Trilogy":
            labelSeries.backgroundColor = UIColor(red: 115/255.0, green: 139/255.0, blue: 252/255.0, alpha: 1)
            labelNormalColor.backgroundColor = UIColor(red: 115/255.0, green: 139/255.0, blue: 252/255.0, alpha: 1)
            labelHardColor.backgroundColor = UIColor(red: 115/255.0, green: 139/255.0, blue: 252/255.0, alpha: 1)
            labelMaximumColor.backgroundColor = UIColor(red: 115/255.0, green: 139/255.0, blue: 252/255.0, alpha: 1)
        case "Respect":
            labelSeries.backgroundColor = UIColor(red: 240/255.0, green: 179/255.0, blue: 44/255.0, alpha: 1)
            labelNormalColor.backgroundColor = UIColor(red: 240/255.0, green: 179/255.0, blue: 44/255.0, alpha: 1)
            labelHardColor.backgroundColor = UIColor(red: 240/255.0, green: 179/255.0, blue: 44/255.0, alpha: 1)
            labelMaximumColor.backgroundColor = UIColor(red: 240/255.0, green: 179/255.0, blue: 44/255.0, alpha: 1)
        case "Portable1":
            labelSeries.backgroundColor = UIColor(red: 29/255.0, green: 180/255.0, blue: 210/255.0, alpha: 1)
            labelNormalColor.backgroundColor = UIColor(red: 29/255.0, green: 180/255.0, blue: 210/255.0, alpha: 1)
            labelHardColor.backgroundColor = UIColor(red: 29/255.0, green: 180/255.0, blue: 210/255.0, alpha: 1)
            labelMaximumColor.backgroundColor = UIColor(red: 29/255.0, green: 180/255.0, blue: 210/255.0, alpha: 1)
        case "Portable2":
            labelSeries.backgroundColor = UIColor(red: 252/255.0, green: 34/255.0, blue: 43/255.0, alpha: 1)
            labelNormalColor.backgroundColor = UIColor(red: 252/255.0, green: 34/255.0, blue: 43/255.0, alpha: 1)
            labelHardColor.backgroundColor = UIColor(red: 252/255.0, green: 34/255.0, blue: 43/255.0, alpha: 1)
            labelMaximumColor.backgroundColor = UIColor(red: 252/255.0, green: 34/255.0, blue: 43/255.0, alpha: 1)
        case "CE":
            labelSeries.backgroundColor = UIColor(red: 255/255.0, green: 248/255.0, blue: 221/255.0, alpha: 1)
            labelNormalColor.backgroundColor = UIColor(red: 255/255.0, green: 248/255.0, blue: 221/255.0, alpha: 1)
            labelHardColor.backgroundColor = UIColor(red: 255/255.0, green: 248/255.0, blue: 221/255.0, alpha: 1)
            labelMaximumColor.backgroundColor = UIColor(red: 255/255.0, green: 248/255.0, blue: 221/255.0, alpha: 1)
        default:
            break
        }
        initializing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func changeSegmentedControl(_ sender: UISegmentedControl) {
        showDifficulty()
        initializing()
    }
    
    
    @IBAction func clickButton(_ sender: UIButton) {
        switch(sender.tag){
        case 1:
            showRankAlert(difficulty: "normal")
        case 2:
            showAccuracyAlert(difficulty: "normal")
        case 3:
            showNoteAlert(difficulty: "normal")
        case 4:
            showRankAlert(difficulty: "hard")
        case 5:
            showAccuracyAlert(difficulty: "hard")
        case 6:
            showNoteAlert(difficulty: "hard")
        case 7:
            showRankAlert(difficulty: "maximum")
        case 8:
            showAccuracyAlert(difficulty: "maximum")
        case 9:
            showNoteAlert(difficulty: "maximum")
        default:
            break
        }
    }
    
    func showRankAlert(difficulty: String){
        let alert=UIAlertController(title: "Rank".localized, message: "Select your rank.".localized, preferredStyle: .alert)
        let initializeAction=UIAlertAction(title: "-", style: .default){(action: UIAlertAction)->Void in
            self.setRank(rank: nil, difficulty: difficulty)
            self.initializing()
        }
        let sAction=UIAlertAction(title: "S", style: .default){(action: UIAlertAction)->Void in
            self.setRank(rank: "S", difficulty: difficulty)
            self.initializing()
            self.showAccuracyAlert(difficulty: difficulty)
        }
        let aAction=UIAlertAction(title: "A", style: .default){(action: UIAlertAction)->Void in
            self.setRank(rank: "A", difficulty: difficulty)
            self.initializing()
            self.showAccuracyAlert(difficulty: difficulty)
        }
        let bAction=UIAlertAction(title: "B", style: .default){(action: UIAlertAction)->Void in
            self.setRank(rank: "B", difficulty: difficulty)
            self.initializing()
            self.showAccuracyAlert(difficulty: difficulty)
        }
        let cAction=UIAlertAction(title: "C", style: .default){(action: UIAlertAction)->Void in
            self.setRank(rank: "C", difficulty: difficulty)
            self.initializing()
            self.showAccuracyAlert(difficulty: difficulty)
        }
        let noAction=UIAlertAction(title: "Cancel".localized, style: .default, handler: nil)
        alert.addAction(initializeAction)
        alert.addAction(sAction)
        alert.addAction(aAction)
        alert.addAction(bAction)
        alert.addAction(cAction)
        alert.addAction(noAction)
        present(alert, animated: true)
    }
    
    func showAccuracyAlert(difficulty: String){
        let alert=UIAlertController(title: "Accuracy".localized, message: "Input your accuracy.\nTo reset the value, do not enter any values.".localized, preferredStyle: .alert)
        alert.addTextField { (textField) -> Void in
            textField.keyboardType = UIKeyboardType.decimalPad
            textField.placeholder = "Accuracy".localized
        }
        let yesAction=UIAlertAction(title: "OK".localized, style: .default){(action: UIAlertAction)->Void in
            var accuracy: String? = nil
            guard let input = Double(alert.textFields![0].text!) else{
                self.setAccuracy(accuracy: nil, difficulty: difficulty)
                self.initializing()
                return
            }
            accuracy = input >= 100.00 ? String(100.00) : String(input)
            self.setAccuracy(accuracy: accuracy, difficulty: difficulty)
            switch(input){
            case 98...100:
                self.setRank(rank: "S", difficulty: difficulty)
            case 95..<98:
                self.setRank(rank: "A", difficulty: difficulty)
            case 90..<95:
                self.setRank(rank: "B", difficulty: difficulty)
            case 0..<90:
                self.setRank(rank: "C", difficulty: difficulty)
            default:
                break
            }
            self.initializing()
            self.showNoteAlert(difficulty: difficulty)
        }
        let noAction=UIAlertAction(title: "Cancel".localized, style: .default, handler: nil)
        alert.addAction(noAction)
        alert.addAction(yesAction)
        present(alert, animated: true)
    }
    
    func showNoteAlert(difficulty: String){
        let alert=UIAlertController(title: "Note".localized, message: "Select your note.".localized, preferredStyle: .alert)
        let initializeAction=UIAlertAction(title: "-", style: .default){(action: UIAlertAction)->Void in
            self.setNote(note: nil, difficulty: difficulty)
            self.initializing()
        }
        let maxcomboAction=UIAlertAction(title: "MAX COMBO", style: .default){(action: UIAlertAction)->Void in
            self.setNote(note: "MAX COMBO", difficulty: difficulty)
            self.initializing()
        }
        let perfectplayAction=UIAlertAction(title: "PERFECT PLAY", style: .default){(action: UIAlertAction)->Void in
            self.setAccuracy(accuracy: "100", difficulty: difficulty)
            self.setRank(rank: "S", difficulty: difficulty)
            self.setNote(note: "PERFECT PLAY", difficulty: difficulty)
            self.initializing()
        }
        let noAction=UIAlertAction(title: "Cancel".localized, style: .default, handler: nil)
        alert.addAction(initializeAction)
        alert.addAction(maxcomboAction)
        alert.addAction(perfectplayAction)
        alert.addAction(noAction)
        present(alert, animated: true)
    }
    
    func setRank(rank: String?, difficulty: String){
        switch(self.segmentedControl.selectedSegmentIndex){
        case 0:
            try! realm.write{
                switch(difficulty){
                case "normal":
                    record!.nm4Rank=rank ?? "-"
                case "hard":
                    record!.hd4Rank=rank ?? "-"
                case "maximum":
                    record!.mx4Rank=rank ?? "-"
                default:
                    break
                }
            }
        case 1:
            try! realm.write{
                switch(difficulty){
                case "normal":
                    record!.nm5Rank=rank ?? "-"
                case "hard":
                    record!.hd5Rank=rank ?? "-"
                case "maximum":
                    record!.mx5Rank=rank ?? "-"
                default:
                    break
                }
            }
        case 2:
            try! realm.write{
                switch(difficulty){
                case "normal":
                    record!.nm6Rank=rank ?? "-"
                case "hard":
                    record!.hd6Rank=rank ?? "-"
                case "maximum":
                    record!.mx6Rank=rank ?? "-"
                default:
                    break
                }
            }
        case 3:
            try! realm.write{
                switch(difficulty){
                case "normal":
                    record!.nm8Rank=rank ?? "-"
                case "hard":
                    record!.hd8Rank=rank ?? "-"
                case "maximum":
                    record!.mx8Rank=rank ?? "-"
                default:
                    break
                }
            }
        default:
            break
        }
        showNotification()
    }
    
    func setAccuracy(accuracy: String?, difficulty: String){
        var value: String? = nil
        if(accuracy != nil){
            value=String(format: "%05.2f%%", Double(accuracy!)!)
        }
        switch(self.segmentedControl.selectedSegmentIndex){
        case 0:
            try! realm.write{
                switch(difficulty){
                case "normal":
                    record!.nm4Rate=value ?? "-"
                case "hard":
                    record!.hd4Rate=value ?? "-"
                case "maximum":
                    record!.mx4Rate=value ?? "-"
                default:
                    break
                }
            }
            let nm4Point = getSkillPoint(difficulty: record!.nm4, rate: record!.nm4Rate, note: record!.nm4Note)
            let hd4Point = getSkillPoint(difficulty: record!.hd4, rate: record!.hd4Rate, note: record!.hd4Note)
            let mx4Point = getSkillPoint(difficulty: record!.mx4, rate: record!.mx4Rate, note: record!.mx4Note)
            let max4Point = [nm4Point, hd4Point, mx4Point].sorted()[2]
            try! realm.write{
                record!.button4SkillPoint = max4Point
            }
            showSkillPoint(sender: 0)
        case 1:
            try! realm.write{
                switch(difficulty){
                case "normal":
                    record!.nm5Rate=value ?? "-"
                case "hard":
                    record!.hd5Rate=value ?? "-"
                case "maximum":
                    record!.mx5Rate=value ?? "-"
                default:
                    break
                }
            }
            let nm5Point = getSkillPoint(difficulty: record!.nm5, rate: record!.nm5Rate, note: record!.nm5Note)
            let hd5Point = getSkillPoint(difficulty: record!.hd5, rate: record!.hd5Rate, note: record!.hd5Note)
            let mx5Point = getSkillPoint(difficulty: record!.mx5, rate: record!.mx5Rate, note: record!.mx5Note)
            let max5Point = [nm5Point, hd5Point, mx5Point].sorted()[2]
            try! realm.write{
                record!.button5SkillPoint = max5Point
            }
            showSkillPoint(sender: 1)
        case 2:
            try! realm.write{
                switch(difficulty){
                case "normal":
                    record!.nm6Rate=value ?? "-"
                case "hard":
                    record!.hd6Rate=value ?? "-"
                case "maximum":
                    record!.mx6Rate=value ?? "-"
                default:
                    break
                }
            }
            let nm6Point = getSkillPoint(difficulty: record!.nm6, rate: record!.nm6Rate, note: record!.nm6Note)
            let hd6Point = getSkillPoint(difficulty: record!.hd6, rate: record!.hd6Rate, note: record!.hd6Note)
            let mx6Point = getSkillPoint(difficulty: record!.mx6, rate: record!.mx6Rate, note: record!.mx6Note)
            let max6Point = [nm6Point, hd6Point, mx6Point].sorted()[2]
            try! realm.write{
                record!.button6SkillPoint = max6Point
            }
            showSkillPoint(sender: 2)
        case 3:
            try! realm.write{
                switch(difficulty){
                case "normal":
                    record!.nm8Rate=value ?? "-"
                case "hard":
                    record!.hd8Rate=value ?? "-"
                case "maximum":
                    record!.mx8Rate=value ?? "-"
                default:
                    break
                }
            }
            let nm8Point = getSkillPoint(difficulty: record!.nm8, rate: record!.nm8Rate, note: record!.nm8Note)
            let hd8Point = getSkillPoint(difficulty: record!.hd8, rate: record!.hd8Rate, note: record!.hd8Note)
            let mx8Point = getSkillPoint(difficulty: record!.mx8, rate: record!.mx8Rate, note: record!.mx8Note)
            let max8Point = [nm8Point, hd8Point, mx8Point].sorted()[2]
            try! realm.write{
                record!.button8SkillPoint = max8Point
            }
            showSkillPoint(sender: 3)
        default:
            break
        }
        showNotification()
    }
    
    func setNote(note: String?, difficulty: String){
        switch(self.segmentedControl.selectedSegmentIndex){
        case 0:
            try! realm.write{
                switch(difficulty){
                case "normal":
                    record!.nm4Note=note ?? "-"
                case "hard":
                    record!.hd4Note=note ?? "-"
                case "maximum":
                    record!.mx4Note=note ?? "-"
                default:
                    break
                }
            }
            let nm4Point = getSkillPoint(difficulty: record!.nm4, rate: record!.nm4Rate, note: record!.nm4Note)
            let hd4Point = getSkillPoint(difficulty: record!.hd4, rate: record!.hd4Rate, note: record!.hd4Note)
            let mx4Point = getSkillPoint(difficulty: record!.mx4, rate: record!.mx4Rate, note: record!.mx4Note)
            let max4Point = [nm4Point, hd4Point, mx4Point].sorted()[2]
            try! realm.write{
                record!.button4SkillPoint = max4Point
            }
            showSkillPoint(sender: 0)
        case 1:
            try! realm.write{
                switch(difficulty){
                case "normal":
                    record!.nm5Note=note ?? "-"
                case "hard":
                    record!.hd5Note=note ?? "-"
                case "maximum":
                    record!.mx5Note=note ?? "-"
                default:
                    break
                }
            }
            let nm5Point = getSkillPoint(difficulty: record!.nm5, rate: record!.nm5Rate, note: record!.nm5Note)
            let hd5Point = getSkillPoint(difficulty: record!.hd5, rate: record!.hd5Rate, note: record!.hd5Note)
            let mx5Point = getSkillPoint(difficulty: record!.mx5, rate: record!.mx5Rate, note: record!.mx5Note)
            let max5Point = [nm5Point, hd5Point, mx5Point].sorted()[2]
            try! realm.write{
                record!.button5SkillPoint = max5Point
            }
            showSkillPoint(sender: 1)
        case 2:
            try! realm.write{
                switch(difficulty){
                case "normal":
                    record!.nm6Note=note ?? "-"
                case "hard":
                    record!.hd6Note=note ?? "-"
                case "maximum":
                    record!.mx6Note=note ?? "-"
                default:
                    break
                }
            }
            let nm6Point = getSkillPoint(difficulty: record!.nm6, rate: record!.nm6Rate, note: record!.nm6Note)
            let hd6Point = getSkillPoint(difficulty: record!.hd6, rate: record!.hd6Rate, note: record!.hd6Note)
            let mx6Point = getSkillPoint(difficulty: record!.mx6, rate: record!.mx6Rate, note: record!.mx6Note)
            let max6Point = [nm6Point, hd6Point, mx6Point].sorted()[2]
            try! realm.write{
                record!.button6SkillPoint = max6Point
            }
            showSkillPoint(sender: 2)
        case 3:
            try! realm.write{
                switch(difficulty){
                case "normal":
                    record!.nm8Note=note ?? "-"
                case "hard":
                    record!.hd8Note=note ?? "-"
                case "maximum":
                    record!.mx8Note=note ?? "-"
                default:
                    break
                }
            }
            let nm8Point = getSkillPoint(difficulty: record!.nm8, rate: record!.nm8Rate, note: record!.nm8Note)
            let hd8Point = getSkillPoint(difficulty: record!.hd8, rate: record!.hd8Rate, note: record!.hd8Note)
            let mx8Point = getSkillPoint(difficulty: record!.mx8, rate: record!.mx8Rate, note: record!.mx8Note)
            let max8Point = [nm8Point, hd8Point, mx8Point].sorted()[2]
            try! realm.write{
                record!.button8SkillPoint = max8Point
            }
            showSkillPoint(sender: 3)
        default:
            break
        }
        showNotification()
    }
    
    func buttonSetting(key: String){
        setButtonEnaled()
        switch(key){
        case "4B":
            buttonNormalRank.setTitle(record?.nm4Rank, for: .normal)
            buttonNormalAccuracy.setTitle(record?.nm4Rate, for: .normal)
            buttonNormalNote.setTitle(record?.nm4Note, for: .normal)
            buttonHardRank.setTitle(record?.hd4Rank, for: .normal)
            buttonHardAccuracy.setTitle(record?.hd4Rate, for: .normal)
            buttonHardNote.setTitle(record?.hd4Note, for: .normal)
            buttonMaximumRank.setTitle(record?.mx4Rank, for: .normal)
            buttonMaximumAccuracy.setTitle(record?.mx4Rate, for: .normal)
            buttonMaximumNote.setTitle(record?.mx4Note, for: .normal)
        case "5B":
            buttonNormalRank.setTitle(record?.nm5Rank, for: .normal)
            buttonNormalAccuracy.setTitle(record?.nm5Rate, for: .normal)
            buttonNormalNote.setTitle(record?.nm5Note, for: .normal)
            buttonHardRank.setTitle(record?.hd5Rank, for: .normal)
            buttonHardAccuracy.setTitle(record?.hd5Rate, for: .normal)
            buttonHardNote.setTitle(record?.hd5Note, for: .normal)
            buttonMaximumRank.setTitle(record?.mx5Rank, for: .normal)
            buttonMaximumAccuracy.setTitle(record?.mx5Rate, for: .normal)
            buttonMaximumNote.setTitle(record?.mx5Note, for: .normal)
        case "6B":
            buttonNormalRank.setTitle(record?.nm6Rank, for: .normal)
            buttonNormalAccuracy.setTitle(record?.nm6Rate, for: .normal)
            buttonNormalNote.setTitle(record?.nm6Note, for: .normal)
            buttonHardRank.setTitle(record?.hd6Rank, for: .normal)
            buttonHardAccuracy.setTitle(record?.hd6Rate, for: .normal)
            buttonHardNote.setTitle(record?.hd6Note, for: .normal)
            buttonMaximumRank.setTitle(record?.mx6Rank, for: .normal)
            buttonMaximumAccuracy.setTitle(record?.mx6Rate, for: .normal)
            buttonMaximumNote.setTitle(record?.mx6Note, for: .normal)
        case "8B":
            buttonNormalRank.setTitle(record?.nm8Rank, for: .normal)
            buttonNormalAccuracy.setTitle(record?.nm8Rate, for: .normal)
            buttonNormalNote.setTitle(record?.nm8Note, for: .normal)
            buttonHardRank.setTitle(record?.hd8Rank, for: .normal)
            buttonHardAccuracy.setTitle(record?.hd8Rate, for: .normal)
            buttonHardNote.setTitle(record?.hd8Note, for: .normal)
            buttonMaximumRank.setTitle(record?.mx8Rank, for: .normal)
            buttonMaximumAccuracy.setTitle(record?.mx8Rate, for: .normal)
            buttonMaximumNote.setTitle(record?.mx8Note, for: .normal)
        default:
            break
        }
    }
    
    func initializing(){
        showSkillPoint(sender: segmentedControl.selectedSegmentIndex)
        switch(segmentedControl.selectedSegmentIndex){
        case 0:
            buttonSetting(key: "4B")
            if(!is4BNormalExist){
                buttonNormalRank.isEnabled = false
                buttonNormalAccuracy.isEnabled = false
                buttonNormalNote.isEnabled = false
                buttonNormalRank.setTitle("No Pattern".localized, for: .normal)
                buttonNormalAccuracy.setTitle("No Pattern".localized, for: .normal)
                buttonNormalNote.setTitle("No Pattern".localized, for: .normal)
            }
            if(!is4BHardExist){
                buttonHardRank.isEnabled = false
                buttonHardAccuracy.isEnabled = false
                buttonHardNote.isEnabled = false
                buttonHardRank.setTitle("No Pattern".localized, for: .normal)
                buttonHardAccuracy.setTitle("No Pattern".localized, for: .normal)
                buttonHardNote.setTitle("No Pattern".localized, for: .normal)
            }
            if(!is4BMaximumExist){
                buttonMaximumRank.isEnabled = false
                buttonMaximumAccuracy.isEnabled = false
                buttonMaximumNote.isEnabled = false
                buttonMaximumRank.setTitle("No Pattern".localized, for: .normal)
                buttonMaximumAccuracy.setTitle("No Pattern".localized, for: .normal)
                buttonMaximumNote.setTitle("No Pattern".localized, for: .normal)
            }
        case 1:
            buttonSetting(key: "5B")
            if(!is5BNormalExist){
                buttonNormalRank.isEnabled = false
                buttonNormalAccuracy.isEnabled = false
                buttonNormalNote.isEnabled = false
                buttonNormalRank.setTitle("No Pattern".localized, for: .normal)
                buttonNormalAccuracy.setTitle("No Pattern".localized, for: .normal)
                buttonNormalNote.setTitle("No Pattern".localized, for: .normal)
            }
            if(!is5BHardExist){
                buttonHardRank.isEnabled = false
                buttonHardAccuracy.isEnabled = false
                buttonHardNote.isEnabled = false
                buttonHardRank.setTitle("No Pattern".localized, for: .normal)
                buttonHardAccuracy.setTitle("No Pattern".localized, for: .normal)
                buttonHardNote.setTitle("No Pattern".localized, for: .normal)
            }
            if(!is5BMaximumExist){
                buttonMaximumRank.isEnabled = false
                buttonMaximumAccuracy.isEnabled = false
                buttonMaximumNote.isEnabled = false
                buttonMaximumRank.setTitle("No Pattern".localized, for: .normal)
                buttonMaximumAccuracy.setTitle("No Pattern".localized, for: .normal)
                buttonMaximumNote.setTitle("No Pattern".localized, for: .normal)
            }
        case 2:
            buttonSetting(key: "6B")
            if(!is6BNormalExist){
                buttonNormalRank.isEnabled = false
                buttonNormalAccuracy.isEnabled = false
                buttonNormalNote.isEnabled = false
                buttonNormalRank.setTitle("No Pattern".localized, for: .normal)
                buttonNormalAccuracy.setTitle("No Pattern".localized, for: .normal)
                buttonNormalNote.setTitle("No Pattern".localized, for: .normal)
            }
            if(!is6BHardExist){
                buttonHardRank.isEnabled = false
                buttonHardAccuracy.isEnabled = false
                buttonHardNote.isEnabled = false
                buttonHardRank.setTitle("No Pattern".localized, for: .normal)
                buttonHardAccuracy.setTitle("No Pattern".localized, for: .normal)
                buttonHardNote.setTitle("No Pattern".localized, for: .normal)
            }
            if(!is6BMaximumExist){
                buttonMaximumRank.isEnabled = false
                buttonMaximumAccuracy.isEnabled = false
                buttonMaximumNote.isEnabled = false
                buttonMaximumRank.setTitle("No Pattern".localized, for: .normal)
                buttonMaximumAccuracy.setTitle("No Pattern".localized, for: .normal)
                buttonMaximumNote.setTitle("No Pattern".localized, for: .normal)
            }
        case 3:
            buttonSetting(key: "8B")
            if(!is8BNormalExist){
                buttonNormalRank.isEnabled = false
                buttonNormalAccuracy.isEnabled = false
                buttonNormalNote.isEnabled = false
                buttonNormalRank.setTitle("No Pattern".localized, for: .normal)
                buttonNormalAccuracy.setTitle("No Pattern".localized, for: .normal)
                buttonNormalNote.setTitle("No Pattern".localized, for: .normal)
            }
            if(!is8BHardExist){
                buttonHardRank.isEnabled = false
                buttonHardAccuracy.isEnabled = false
                buttonHardNote.isEnabled = false
                buttonHardRank.setTitle("No Pattern".localized, for: .normal)
                buttonHardAccuracy.setTitle("No Pattern".localized, for: .normal)
                buttonHardNote.setTitle("No Pattern".localized, for: .normal)
            }
            if(!is8BMaximumExist){
                buttonMaximumRank.isEnabled = false
                buttonMaximumAccuracy.isEnabled = false
                buttonMaximumNote.isEnabled = false
                buttonMaximumRank.setTitle("No Pattern".localized, for: .normal)
                buttonMaximumAccuracy.setTitle("No Pattern".localized, for: .normal)
                buttonMaximumNote.setTitle("No Pattern".localized, for: .normal)
            }
        default:
            break
        }
    }
    
    func showDifficulty(){
        switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            labelNormalDifficulty.text = nm4 == 0 ? "" : difficultyToChar(value: nm4)
            labelHardDifficulty.text = hd4 == 0 ? "" : difficultyToChar(value: hd4)
            labelMaximumDifficulty.text = mx4 == 0 ? "" : difficultyToChar(value: mx4)
        case 1:
            labelNormalDifficulty.text = nm5 == 0 ? "" : difficultyToChar(value: nm5)
            labelHardDifficulty.text = hd5 == 0 ? "" : difficultyToChar(value: hd5)
            labelMaximumDifficulty.text = mx5 == 0 ? "" : difficultyToChar(value: mx5)
        case 2:
            labelNormalDifficulty.text = nm6 == 0 ? "" : difficultyToChar(value: nm6)
            labelHardDifficulty.text = hd6 == 0 ? "" : difficultyToChar(value: hd6)
            labelMaximumDifficulty.text = mx6 == 0 ? "" : difficultyToChar(value: mx6)
        case 3:
            labelNormalDifficulty.text = nm8 == 0 ? "" : difficultyToChar(value: nm8)
            labelHardDifficulty.text = hd8 == 0 ? "" : difficultyToChar(value: hd8)
            labelMaximumDifficulty.text = mx8 == 0 ? "" : difficultyToChar(value: mx8)
        default:
            break
        }
    }
    
    func difficultyToChar(value: Int)->String{
        var char: String=""
        switch(value){
        case 1...5:
            for _ in 1...value{
                char=char+"★"
            }
        case 6...10:
            char="☆☆☆☆☆"
            for _ in 6...value{
                char=char+"★"
            }
        case 11...15:
            char="☆☆☆☆☆☆☆☆☆☆"
            for _ in 11...value{
                char=char+"★"
            }
        default:
            break
        }
        return char
    }
    
    func setButtonEnaled(){
        buttonNormalRank.isEnabled = true
        buttonNormalAccuracy.isEnabled = true
        buttonNormalNote.isEnabled = true
        buttonHardRank.isEnabled = true
        buttonHardAccuracy.isEnabled = true
        buttonHardNote.isEnabled = true
        buttonMaximumRank.isEnabled = true
        buttonMaximumAccuracy.isEnabled = true
        buttonMaximumNote.isEnabled = true
    }
    
    func showSkillPoint(sender: Int){
        switch(sender){
        case 0:
            labelSkillPoint.text = "Skill Point".localized + " : \(record?.button4SkillPoint ?? 0)"
        case 1:
            labelSkillPoint.text = "Skill Point".localized + " : \(record?.button5SkillPoint ?? 0)"
        case 2:
            labelSkillPoint.text = "Skill Point".localized + " : \(record?.button6SkillPoint ?? 0)"
        case 3:
            labelSkillPoint.text = "Skill Point".localized + " : \(record?.button8SkillPoint ?? 0)"
        default:
            break
        }
    }
    
    func getSkillPoint(difficulty: Int, rate: String, note: String) -> Double{
        if(difficulty == 0){
            return 0
        }
        var skillPoint: Double
        let e = 2.71828
        let rateString = rate.split(separator: "%")[0].description
        let accuracy = Double(rateString) ?? 0
        let weight = getWeight(value: difficulty)
        if(accuracy >= 80){
            let temp = pow((accuracy - 80) / 20.0, e) + 1
            skillPoint = weight * 50 * temp
        }
        else{
            skillPoint = Double(weight * accuracy * 5) / 8.0
        }
        if(note == "-"){
            skillPoint = skillPoint * 0.98
        }
        else if(note == "PERFECT PLAY"){
            skillPoint = skillPoint * 1.05
        }
        skillPoint = (skillPoint * 100).rounded() / 100
        return skillPoint
    }
    
    func getWeight(value: Int) -> Double{
        var result: Double = 0.0
        switch(value){
        case 1:
            result = 0.4
        case 2:
            result = 0.6
        case 3:
            result = 0.8
        case 4:
            result = 1
        case 5:
            result = 1.14
        case 6:
            result = 1.24
        case 7:
            result = 1.33
        case 8:
            result = 1.42
        case 9:
            result = 1.53
        case 10:
            result = 1.6
        case 11:
            result = 1.68
        case 12:
            result = 1.77
        case 13:
            result = 1.85
        case 14:
            result = 1.94
        case 15:
            result = 2
        default:
            break
        }
        return result
    }
    
    func showNotification(){
        if(NotificationBannerQueue.default.numberOfBanners > 0){
            NotificationBannerQueue.default.removeAll()
        }
        let view=UIImageView(image: #imageLiteral(resourceName: "success"))
        NotificationBanner(title: "Changed".localized, subtitle: "", leftView: view, style: .success).show()
        
    }
}
