//
//  SkillPointCell.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import GaugeKit
import RealmSwift
import Firebase
import PMAlertController

class SkillLevelCell: UITableViewCell {

    @IBOutlet var gauge: Gauge!
    @IBOutlet weak var skillLevel: UILabel!
    @IBOutlet weak var skillPoint: UILabel!
    @IBOutlet weak var top50: UIButton!
    @IBOutlet weak var ranking: UIButton!
    @IBOutlet weak var calculator: UIButton!
    @IBOutlet weak var percent: UILabel!
    @IBOutlet weak var nextLevel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        top50.layer.borderColor = UIColor.mainColor.cgColor
        top50.layer.borderWidth = 2
        ranking.layer.borderColor = UIColor.mainColor.cgColor
        ranking.layer.borderWidth = 2
        calculator.layer.borderColor = UIColor.mainColor.cgColor
        calculator.layer.borderWidth = 2
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func clickTop50(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Top50", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Top50ViewController") as! Top50ViewController
        self.parentViewController()?.present(controller, animated: true, completion: nil)
        
    }
    @IBAction func clickRanking(_ sender: UIButton) {
        if(!Reachability.isConnectedToNetwork()){
            let alert = PMAlertController.showOKButton(title: "Notice".localized, message: "Check your network status.".localized)
            self.parentViewController()?.present(alert, animated: true)
        } else {
            if(Auth.auth().currentUser == nil){
                let alert = PMAlertController.showOKButton(title: "Notice".localized, message: "Log in First.".localized)
                self.parentViewController()?.present(alert, animated: true)
            } else {
                let alert = PMAlertController(title: "", description: "", image: nil, style: .alert)
                let cancel = PMAlertAction(title: "Cancel".localized, style: .cancel)
                let ranking = PMAlertAction(title: "Ranking".localized, style: .default, action: {
                    let storyboard = UIStoryboard(name: "Ranking", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: "RankingViewController")
                    self.parentViewController()?.present(controller, animated: true, completion: nil)
                })
                let upload = PMAlertAction(title: "Upload".localized, style: .default, action: {
                    self.upload()
                })
                designAlertController(alert: alert, actions: ranking, upload, cancel)
                alert.addAction(cancel)
                alert.addAction(upload)
                alert.addAction(ranking)
                self.parentViewController()?.present(alert, animated: true)
            }
        }
    }
    @IBAction func clickCalculator(_ sender: UIButton) {
        let alert = PMAlertController(title: "Skill Point Calculator".localized, description: "", image: nil, style: .alert)
        alert.addTextField { (textField) in
            textField?.placeholder = "Difficulty".localized
            textField?.keyboardType = .numberPad
        }
        alert.addTextField { (textField) in
            textField?.placeholder = "Rate".localized
            textField?.keyboardType = .decimalPad
        }
        let cancel = PMAlertAction(title: "Cancel".localized, style: .cancel)
        let noMaxCombo = PMAlertAction(title: "MAX COMBO Failure".localized, style: .default) {
            if let difficulty = Int((alert.textFields.first?.text!)!), let rate = Double((alert.textFields.last?.text!)!){
                let skillPoint = getSkillPoint(difficulty: difficulty, rate: String(rate), note: "-")
                let alert = PMAlertController.showOKButton(title: "Skill Point".localized, message: "\(skillPoint) " + "Point".localized)
                self.parentViewController()?.present(alert, animated: true)
            } else {
                let alert = PMAlertController.showOKButton(title: "Error".localized, message: "Enter a valid value.".localized)
                self.parentViewController()?.present(alert, animated: true)
            }
        }
        let maxComboOrPerfectPlay = PMAlertAction(title: "MAX COMBO / PERFECT PLAY", style: .default) {
            if let difficulty = Int((alert.textFields.first?.text!)!), let rate = Double((alert.textFields.last?.text!)!){
                if(rate == 100){
                    let skillPoint = getSkillPoint(difficulty: difficulty, rate: String(rate), note: "PERFECT PLAY")
                    let alert = PMAlertController.showOKButton(title: "Skill Point".localized, message: "\(skillPoint) " + "Point".localized)
                    self.parentViewController()?.present(alert, animated: true)
                } else {
                let skillPoint = getSkillPoint(difficulty: difficulty, rate: String(rate), note: "MAX COMBO")
                let alert = PMAlertController.showOKButton(title: "Skill Point".localized, message: "\(skillPoint) " + "Point".localized)
                self.parentViewController()?.present(alert, animated: true)
                }
            } else {
                let alert = PMAlertController.showOKButton(title: "Error".localized, message: "Enter a valid value.".localized)
                self.parentViewController()?.present(alert, animated: true)
            }
        }
        designAlertController(alert: alert, actions: cancel, noMaxCombo, maxComboOrPerfectPlay)
        alert.addAction(cancel)
        alert.addAction(noMaxCombo)
        alert.addAction(maxComboOrPerfectPlay)
        self.parentViewController()?.present(alert, animated: true)
    }
    
    func upload(){
        let button4SkillPoint = getMySkillPoint(button: "4B").sum
        let button5SkillPoint = getMySkillPoint(button: "5B").sum
        let button6SkillPoint = getMySkillPoint(button: "6B").sum
        let button8SkillPoint = getMySkillPoint(button: "8B").sum
        var countPerfect = 0
        let record = try! Realm().objects(RecordInfo.self)
        for i in record{
            if i.nm4Note == "PERFECT PLAY"{
                countPerfect += 1
            }
            if i.hd4Note == "PERFECT PLAY"{
                countPerfect += 1
            }
            if i.mx4Note == "PERFECT PLAY"{
                countPerfect += 1
            }
            if i.nm5Note == "PERFECT PLAY"{
                countPerfect += 1
            }
            if i.hd5Note == "PERFECT PLAY"{
                countPerfect += 1
            }
            if i.mx5Note == "PERFECT PLAY"{
                countPerfect += 1
            }
            if i.nm6Note == "PERFECT PLAY"{
                countPerfect += 1
            }
            if i.hd6Note == "PERFECT PLAY"{
                countPerfect += 1
            }
            if i.mx6Note == "PERFECT PLAY"{
                countPerfect += 1
            }
            if i.nm8Note == "PERFECT PLAY"{
                countPerfect += 1
            }
            if i.hd8Note == "PERFECT PLAY"{
                countPerfect += 1
            }
            if i.mx8Note == "PERFECT PLAY"{
                countPerfect += 1
            }
        }
        Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!).setValue([
            "userId": UserDefaults.standard.string(forKey: "nickname") ?? Auth.auth().currentUser?.email,
            "button4SkillPoint": (button4SkillPoint * 100).rounded() / 100,
            "button5SkillPoint": (button5SkillPoint * 100).rounded() / 100,
            "button6SkillPoint": (button6SkillPoint * 100).rounded() / 100,
            "button8SkillPoint": (button8SkillPoint * 100).rounded() / 100,
            "countPerfectPlay": countPerfect,
            "uid": Auth.auth().currentUser?.uid
            ])
    }
}
