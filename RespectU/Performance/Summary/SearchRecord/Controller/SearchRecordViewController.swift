//
//  SearchByConditionViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 19..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

class SearchRecordViewController: UIViewController {

    var selectedButton: Int = -1
    var selectedType: Int = -1
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var buttonByLevel: UIButton!
    @IBOutlet weak var buttonByRate: UIButton!
    @IBOutlet weak var buttonByNote: UIButton!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var buttonSearch: UIButton!
    @IBOutlet weak var labelFirst: UILabel!
    @IBOutlet weak var labelSecond: UILabel!
    var buttons = [UIButton?]()
    var types = [UIButton?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelFirst.text = "Select Button".localized
        labelSecond.text = "Select Search Type".localized
        buttonByLevel.setTitle("Level".localized, for: .normal)
        buttonByRate.setTitle("Rate".localized, for: .normal)
        buttonByNote.setTitle("Note".localized, for: .normal)
        buttonSearch.setTitle("Enter all conditions".localized, for: .disabled)
        buttonSearch.setTitle("Search".localized, for: .normal)
        buttons = [button4, button5, button6, button8]
        types = [buttonByLevel, buttonByRate, buttonByNote]
        initializeButtons()
        initializeTypes()
    }

    static func instantiate() -> SearchRecordViewController? {
        guard let viewController = UIStoryboard(name: "Performance", bundle: nil).instantiateViewController(withIdentifier: classNameToString) as? SearchRecordViewController else { return nil }
        return viewController
    }
    
    @IBAction func touchUpSearchButton(_ sender: UIButton) {
        let controller = SearchRecordDetailViewController.instantiate()!
        controller.button = { () -> Int in
            for i in 0..<buttons.count {
                if(buttons[i]?.isSelected)!{
                    return i
                }
            }
            return -1
        }()
        controller.searchType = { () -> Int in
            for i in 0..<types.count{
                if(types[i]?.isSelected)!{
                    return i
                }
            }
            return -1
        }()
        if(buttonByLevel.isSelected){
            //레벨정렬
            let levelView = subView.subviews.first as! SearchByLevelView
            controller.level = levelView.selectedLevel
        } else if(buttonByRate.isSelected){
            let rateView = subView.subviews.first as! SearchByRateView
            controller.lowerRange = Double((rateView.lowerRateTextField.text)!)!
            controller.upperRange = Double((rateView.upperRateTextField.text)!)!
        } else if(buttonByNote.isSelected){
            let noteView = subView.subviews.first as! SearchByNoteView
            controller.detailType = { () -> Int in
                if(noteView.buttonNoMCs.isSelected){
                    return 0
                } else {
                    return 1
                }
            }()
        }
        self.present(controller, animated: true)
    }
    
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchUpButtons(_ sender: UIButton) {
        initializeButtons()
        for button in buttons{
            button?.isSelected = false
        }
        sender.isSelected = true
        UIView.animate(withDuration: 0.3) {
            sender.backgroundColor = UIColor.main
        }
        switch(sender.tag){
        case 0:
            selectedButton = 0
        case 1:
            selectedButton = 1
        case 2:
            selectedButton = 2
        case 3:
            selectedButton = 3
        default:
            break
        }
        checkValidate()
    }
    
    @IBAction func touchUpTypesButton(_ sender: UIButton) {
        if(subView.subviews.first is SearchByRateView){
            
        } else if(subView.subviews.first is SearchByNoteView){
            (subView.subviews.first as! SearchByNoteView).selectedDetailNote = -1
        }
        if(subView.subviews.count != 0){
            subView.subviews.first?.removeFromSuperview()
        }
        initializeTypes()
        for type in types{
            type?.isSelected = false
        }
        sender.isSelected = true
        UIView.animate(withDuration: 0.3) {
            sender.backgroundColor = UIColor.main
        }
        switch(sender.tag){
        case 0:
            selectedType = 0
            guard let newView = UIView.instanceFromXib(xibName: "SearchByLevelView") as? SearchByLevelView else { return }
            newView.frame.size = subView.frame.size
            newView.pickerView.frame.size.height = button4.frame.height
            newView.pickerView.frame.origin.x = button4.frame.origin.x
            newView.pickerView.frame.size.width = button8.frame.origin.x + button8.frame.width - button4.frame.origin.x
            subView.addSubview(newView)
        case 1:
            selectedType = 1
            guard let newView = UIView.instanceFromXib(xibName: "SearchByRateView") as? SearchByRateView else { return }
            newView.frame.size = subView.frame.size
            newView.lowerRateTextField.frame.origin.x = button4.frame.origin.x
            newView.lowerRateTextField.frame.size.height = button4.frame.height
            newView.upperRateTextField.frame.origin.x = button8.frame.origin.x + button8.frame.width - newView.lowerRateTextField.frame.width
            newView.upperRateTextField.frame.size = newView.lowerRateTextField.frame.size
            newView.lowerRateTextField.addTarget(self, action: #selector(endEdit), for: .editingDidEnd)
            newView.upperRateTextField.addTarget(self, action: #selector(endEdit), for: .editingDidEnd)
            subView.addSubview(newView)
        case 2:
            selectedType = 2
            guard let newView = UIView.instanceFromXib(xibName: "SearchByNoteView") as? SearchByNoteView else { return }
            newView.frame.size = subView.frame.size
            newView.buttonNoMCs.frame.origin.x = button4.frame.origin.x
            newView.buttonNoMCs.frame.size.width = (button5.frame.origin.x - button4.frame.origin.x - button4.frame.width) + button4.frame.width * 2
            newView.buttonNoMCs.frame.size.height = button4.frame.height
            newView.buttonPPs.frame.origin.x = button6.frame.origin.x
            newView.buttonPPs.frame.size = newView.buttonNoMCs.frame.size
            newView.buttonNoMCs.addTarget(self, action: #selector(clickNewViewButton), for: .touchUpInside)
            newView.buttonPPs.addTarget(self, action: #selector(clickNewViewButton), for: .touchUpInside)
            subView.addSubview(newView)
        default:
            break
        }
        checkValidate()
    }
    
    @objc func clickNewViewButton(_ sender: UIButton){
        checkValidate()
    }
    @objc func endEdit(_ sender: UITextField){
        checkValidate()
    }
    
    func initializeButtons(){
        for button in buttons{
            UIView.animate(withDuration: 0.3) {
                button?.backgroundColor = UIColor.sub
            }
            button?.layer.borderColor = UIColor.main.cgColor
            button?.layer.borderWidth = 2
        }
    }
    
    func initializeTypes(){
        for type in types{
            UIView.animate(withDuration: 0.3) {
                type?.backgroundColor = UIColor.sub
            }
            type?.layer.borderColor = UIColor.main.cgColor
            type?.layer.borderWidth = 2
        }
    }
    
    func checkValidate(){
        buttonSearch.isEnabled = false
        if(subView.subviews.first is SearchByLevelView){
            let newView = subView.subviews.first as! SearchByLevelView
            if(newView.selectedLevel != 0){
                buttonSearch.isEnabled = true
            }
        } else if(subView.subviews.first is SearchByRateView){
            let newView = subView.subviews.first as! SearchByRateView
            guard let lowerText = newView.lowerRateTextField.text else { return }
            guard let upperText = newView.upperRateTextField.text else { return }
            guard let lower = Double(lowerText) else { return }
            guard let upper = Double(upperText) else { return }
            if(upper < lower) { return }
            buttonSearch.isEnabled = true
        } else if(subView.subviews.first is SearchByNoteView){
            let newView = subView.subviews.first as! SearchByNoteView
            if(newView.selectedDetailNote != -1 && selectedType != -1 && selectedButton != -1){
                buttonSearch.isEnabled = true
            }
        } 
    }
}
