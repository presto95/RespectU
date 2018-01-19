//
//  RateCalculatorViewController.swift
//  RespectU
//
//  Created by Presto on 2017. 12. 11..
//  Copyright © 2017년 Presto. All rights reserved.
//

import UIKit

class RateCalculatorViewController: UIViewController {

    @IBOutlet weak var max100: UILabel!
    @IBOutlet weak var max90: UILabel!
    @IBOutlet weak var max80: UILabel!
    @IBOutlet weak var max70: UILabel!
    @IBOutlet weak var max60: UILabel!
    @IBOutlet weak var max50: UILabel!
    @IBOutlet weak var max40: UILabel!
    @IBOutlet weak var max30: UILabel!
    @IBOutlet weak var max20: UILabel!
    @IBOutlet weak var max10: UILabel!
    @IBOutlet weak var max1: UILabel!
    @IBOutlet weak var _break: UILabel!
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var textMax100: UITextField!
    @IBOutlet weak var textMax90: UITextField!
    @IBOutlet weak var textMax80: UITextField!
    @IBOutlet weak var textMax70: UITextField!
    @IBOutlet weak var textMax60: UITextField!
    @IBOutlet weak var textMax50: UITextField!
    @IBOutlet weak var textMax40: UITextField!
    @IBOutlet weak var textMax30: UITextField!
    @IBOutlet weak var textMax20: UITextField!
    @IBOutlet weak var textMax10: UITextField!
    @IBOutlet weak var textMax1: UITextField!
    @IBOutlet weak var textBreak: UITextField!
    @IBOutlet weak var note: UILabel!
    @IBOutlet weak var labelNote: UILabel!
    @IBOutlet weak var labelRate: UILabel!
    
    let isNight=UserDefaults.standard.bool(forKey: "night")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "RATE Calculator".localized
        tabBarController?.tabBar.barStyle = isNight ? .black : .default
        navigationController?.navigationBar.barStyle = isNight ? .black : .default
        view.backgroundColor=isNight ? UIColor(red: 0, green: 0, blue: 0, alpha: 1) : UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        let toolBar=UIToolbar()
        toolBar.sizeToFit()
        let prevButton = UIBarButtonItem(title: "Prev".localized, style: .plain, target: self, action: #selector(self.prevClicked))
        let nextButton=UIBarButtonItem(title: "Next".localized, style: .plain, target: self, action: #selector(self.nextClicked))
        let flexButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButton=UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.doneClicked))
        toolBar.setItems([prevButton, nextButton, flexButton, doneButton], animated: false)
        textMax100.inputAccessoryView = toolBar
        textMax90.inputAccessoryView = toolBar
        textMax80.inputAccessoryView = toolBar
        textMax70.inputAccessoryView = toolBar
        textMax60.inputAccessoryView = toolBar
        textMax50.inputAccessoryView = toolBar
        textMax40.inputAccessoryView = toolBar
        textMax30.inputAccessoryView = toolBar
        textMax20.inputAccessoryView = toolBar
        textMax10.inputAccessoryView = toolBar
        textMax1.inputAccessoryView = toolBar
        textBreak.inputAccessoryView = toolBar
        max100.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        max90.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        max80.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        max70.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        max60.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        max50.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        max40.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        max30.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        max20.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        max10.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        max1.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        _break.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        rate.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        note.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelNote.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelRate.textColor=isNight ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func calculateRate(_ sender: UIButton) {
        doneClicked()
    }
    

    
    @objc func doneClicked(){
        self.view.endEditing(true)
        let max100 = Int(textMax100.text!) ?? 0
        let max90 = Int(textMax90.text!) ?? 0
        let max80 = Int(textMax80.text!) ?? 0
        let max70 = Int(textMax70.text!) ?? 0
        let max60 = Int(textMax60.text!) ?? 0
        let max50 = Int(textMax50.text!) ?? 0
        let max40 = Int(textMax40.text!) ?? 0
        let max30 = Int(textMax30.text!) ?? 0
        let max20 = Int(textMax20.text!) ?? 0
        let max10 = Int(textMax10.text!) ?? 0
        let max1 = Int(textMax1.text!) ?? 0
        let maxBreak = Int(textBreak.text!) ?? 0
        let noteCount = max100+max90+max80+max70+max60+max50+max40+max30+max20+max10+max1+maxBreak
        let rateDouble = Double(100*max100 + 90*max90 + 80*max80 + 70*max70 + 60*max60 + 50*max50 + 40*max40 + 30*max30 + 20*max20 + 10*max10 + 1*max1) / Double(noteCount)
        if(noteCount == 0){
            note.text="-"
            rate.text="-"
        }
        else{
            note.text = String(noteCount)
            rate.text = String(format: "%.2f%%",rateDouble)
        }
        
    }
    
    @objc func prevClicked(){
        if(textMax100.isFirstResponder){
            textBreak.becomeFirstResponder()
        }
        else if(textMax90.isFirstResponder){
            textMax100.becomeFirstResponder()
        }
        else if(textMax80.isFirstResponder){
            textMax90.becomeFirstResponder()
        }
        else if(textMax70.isFirstResponder){
            textMax80.becomeFirstResponder()
        }
        else if(textMax60.isFirstResponder){
            textMax70.becomeFirstResponder()
        }
        else if(textMax50.isFirstResponder){
            textMax60.becomeFirstResponder()
        }
        else if(textMax40.isFirstResponder){
            textMax50.becomeFirstResponder()
        }
        else if(textMax30.isFirstResponder){
            textMax40.becomeFirstResponder()
        }
        else if(textMax20.isFirstResponder){
            textMax30.becomeFirstResponder()
        }
        else if(textMax10.isFirstResponder){
            textMax20.becomeFirstResponder()
        }
        else if(textMax1.isFirstResponder){
            textMax10.becomeFirstResponder()
        }
        else if(textBreak.isFirstResponder){
            textMax1.becomeFirstResponder()
        }
    }
    
    @objc func nextClicked(){
        if(textMax100.isFirstResponder){
            textMax90.becomeFirstResponder()
        }
        else if(textMax90.isFirstResponder){
            textMax80.becomeFirstResponder()
        }
        else if(textMax80.isFirstResponder){
            textMax70.becomeFirstResponder()
        }
        else if(textMax70.isFirstResponder){
            textMax60.becomeFirstResponder()
        }
        else if(textMax60.isFirstResponder){
            textMax50.becomeFirstResponder()
        }
        else if(textMax50.isFirstResponder){
            textMax40.becomeFirstResponder()
        }
        else if(textMax40.isFirstResponder){
            textMax30.becomeFirstResponder()
        }
        else if(textMax30.isFirstResponder){
            textMax20.becomeFirstResponder()
        }
        else if(textMax20.isFirstResponder){
            textMax10.becomeFirstResponder()
        }
        else if(textMax10.isFirstResponder){
            textMax1.becomeFirstResponder()
        }
        else if(textMax1.isFirstResponder){
            textBreak.becomeFirstResponder()
        }
        else if(textBreak.isFirstResponder){
            textMax100.becomeFirstResponder()
        }
    }
}
