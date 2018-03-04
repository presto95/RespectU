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
                let storyboard = UIStoryboard(name: "Ranking", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "RankingViewController")
                self.parentViewController()?.present(controller, animated: true, completion: nil)
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
}
