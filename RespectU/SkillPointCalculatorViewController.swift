//
//  RateCalculatorViewController.swift
//  RespectU
//
//  Created by Presto on 2017. 12. 11..
//  Copyright © 2017년 Presto. All rights reserved.
//

import UIKit

class SkillPointCalculatorViewController: UIViewController {

    @IBOutlet weak var labelDifficulty: UILabel!
    @IBOutlet weak var labelAccuracy: UILabel!
    @IBOutlet weak var labelMaxCombo: UILabel!
    @IBOutlet weak var labelSkillPoint: UILabel!
    @IBOutlet weak var difficulty: UITextField!
    @IBOutlet weak var accuracy: UITextField!
    @IBOutlet weak var skillPoint: UILabel!
    @IBOutlet weak var switchMaxCombo: UISwitch!
    @IBOutlet weak var labelSkillPointCalculationMethod: UILabel!
    @IBOutlet weak var labelAccuracyUpper80: UILabel!
    @IBOutlet weak var labelAccuracyBelow80: UILabel!
    @IBOutlet weak var labelNote: UILabel!
    @IBOutlet weak var labelPerfectPlay: UILabel!
    @IBOutlet weak var labelNoMaxCombo: UILabel!
    @IBOutlet weak var imageAccuracyUpper80: UIImageView!
    @IBOutlet weak var imageAccuracyBelow80: UIImageView!
    
    let isNight=UserDefaults.standard.bool(forKey: "night")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Skill Point Calculator".localized
        labelDifficulty.text = "Difficulty".localized
        labelAccuracy.text = "Accuracy".localized
        labelSkillPoint.text = "Skill Point".localized
        labelSkillPointCalculationMethod.text = "Skill Point Calculation Method".localized
        labelAccuracyUpper80.text = "Accuracy >= 80".localized
        labelAccuracyBelow80.text = "Accuracy < 80".localized
        labelNote.text = "w : weight / r : accuracy".localized
        labelNoMaxCombo.text = "No MAX COMBO : 2% Penalty".localized
        labelPerfectPlay.text = "PERFECT PLAY : 5% Bonus".localized
        imageAccuracyBelow80.image = isNight ? UIImage(named: "accuracyBelow80Black") : UIImage(named: "accuracyBelow80White")
        imageAccuracyUpper80.image = isNight ? UIImage(named: "accuracyUpper80Black") : UIImage(named: "accuracyUpper80White")
        tabBarController?.tabBar.barStyle = isNight ? .black : .default
        navigationController?.navigationBar.barStyle = isNight ? .black : .default
        view.backgroundColor=isNight ? UIColor(red: 0, green: 0, blue: 0, alpha: 1) : UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        let toolBar=UIToolbar()
        toolBar.sizeToFit()
        let nextButton=UIBarButtonItem(title: "Next".localized, style: .plain, target: self, action: #selector(self.nextClicked))
        let flexButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButton=UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.doneClicked))
        toolBar.setItems([nextButton, flexButton, doneButton], animated: false)
        difficulty.inputAccessoryView = toolBar
        accuracy.inputAccessoryView = toolBar
        labelDifficulty.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelAccuracy.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelMaxCombo.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelSkillPoint.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        difficulty.textColor=isNight ? UIColor(red: 0, green: 0, blue: 0, alpha: 1) : UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        accuracy.textColor=isNight ? UIColor(red: 0, green: 0, blue: 0, alpha: 1) : UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        skillPoint.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func doneClicked(){
        self.view.endEditing(true)
        if(accuracy.text == ""){
            accuracy.text = "0"
        }
        if(Double(accuracy.text!) ?? 0 >= 100){
            accuracy.text = "100.00"
            switchMaxCombo.isOn = true
        }
        else{
            accuracy.text = String(format: "%05.2f%%", Double(accuracy.text!.split(separator: "%")[0].description)!)
        }
        let valSkillPoint = getSkillPoint(difficulty: Int(difficulty.text!) ?? 0, rate: accuracy.text!)
        skillPoint.text = String(valSkillPoint)
    }
    
    @objc func nextClicked(){
        if(difficulty.isFirstResponder){
            accuracy.becomeFirstResponder()
            accuracy.text = ""
        }
        else if(accuracy.isFirstResponder){
            if(Double(accuracy.text!) ?? 0 >= 100.0){
                accuracy.text = "100.00%"
                switchMaxCombo.isOn = true
            }
            difficulty.text = ""
            difficulty.becomeFirstResponder()
        }
    }
    
    @IBAction func isSwitchOn(_ sender: UISwitch) {
        let valSkillPoint = getSkillPoint(difficulty: Int(difficulty.text!) ?? 0, rate: accuracy.text!)
        skillPoint.text = String(valSkillPoint)
    }
    
    func getSkillPoint(difficulty: Int, rate: String) -> Double{
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
        if(accuracy == 100){
            skillPoint = skillPoint * 1.05
        }
        if(!switchMaxCombo.isOn){
            skillPoint = skillPoint * 0.98
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
            result = 0
        }
        return result
    }
}
