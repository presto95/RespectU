//
//  SearchByConditionViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 19..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import AKPickerView_Swift

class SearchRecordViewController: UIViewController {

    let levels = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
    var selectedLevel: Int = 0
    var selectedButton: Int = -1
    var selectedDetailNote: Int = -1
    var selectedMethod: Int = -1
    @IBOutlet weak var button4Button: UIButton!
    @IBOutlet weak var button5Button: UIButton!
    @IBOutlet weak var button6Button: UIButton!
    @IBOutlet weak var button8Button: UIButton!
    @IBOutlet weak var searchByLevelButton: UIButton!
    @IBOutlet weak var searchByRateButton: UIButton!
    @IBOutlet weak var searchByNoteButton: UIButton!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var buttonLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    var buttonButtons = [UIButton?]()
    var methodButtons = [UIButton?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonLabel.text = "Select Button".localized
        typeLabel.text = "Select Search Method".localized
        searchByLevelButton.setTitle("Level".localized, for: .normal)
        searchByRateButton.setTitle("Rate".localized, for: .normal)
        searchByNoteButton.setTitle("Note".localized, for: .normal)
        searchButton.setTitle("Enter all conditions".localized, for: .disabled)
        searchButton.setTitle("Search".localized, for: .normal)
        buttonButtons = [button4Button, button5Button, button6Button, button8Button]
        methodButtons = [searchByLevelButton, searchByRateButton, searchByNoteButton]
        initializeButtons()
        initializeTypes()
    }
    
    @IBAction func touchUpSearchButton(_ sender: UIButton) {
        guard let vc = UIViewController.instantiate(storyboard: "Performance", identifier: SearchRecordDetailViewController.classNameToString) as? SearchRecordDetailViewController else { return }
        vc.button = { () -> Int in
            for i in 0..<buttonButtons.count {
                if(buttonButtons[i]?.isSelected)!{
                    return i
                }
            }
            return -1
        }()
        vc.searchType = { () -> Int in
            for i in 0..<methodButtons.count{
                if(methodButtons[i]?.isSelected)!{
                    return i
                }
            }
            return -1
        }()
        if searchByLevelButton.isSelected {
            vc.level = selectedLevel
        } else if searchByRateButton.isSelected {
            guard let rateView = subView.subviews.first as? SearchByRateView else { return }
            let lowerRate = Double(rateView.lowerRateTextField.text ?? "") ?? 0
            let upperRate = Double(rateView.upperRateTextField.text ?? "") ?? 0
            vc.lowerRange = lowerRate
            vc.upperRange = upperRate
        } else if searchByNoteButton.isSelected {
            guard let noteView = subView.subviews.first as? SearchByNoteView else { return }
            vc.detailType = { () -> Int in
                if noteView.noMaxComboButton.isSelected {
                    return 0
                } else {
                    return 1
                }
            }()
        }
        self.present(vc, animated: true)
    }
    
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchUpButtons(_ sender: UIButton) {
        initializeButtons()
        for button in buttonButtons{
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
        checkValidity()
    }
    
    @IBAction func touchUpMethodButtons(_ sender: UIButton) {
        let view = subView.subviews.first
        if view is SearchByNoteView {
            selectedDetailNote = -1
        }
        if subView.subviews.count != 0 {
            subView.subviews.first?.removeFromSuperview()
        }
        initializeTypes()
        for type in methodButtons {
            type?.isSelected = false
        }
        sender.isSelected = true
        UIView.animate(withDuration: 0.3) {
            sender.backgroundColor = UIColor.main
        }
        switch sender.tag {
        case 0:
            selectedMethod = 0
            guard let newView = UIView.instanceFromXib(xibName: "SearchByLevelView") as? SearchByLevelView else { return }
            newView.frame.size = subView.frame.size
            newView.pickerView.delegate = self
            newView.pickerView.dataSource = self
            newView.pickerView.frame.size.height = button4Button.frame.height
            newView.pickerView.frame.origin.x = button4Button.frame.origin.x
            newView.pickerView.frame.size.width = button8Button.frame.origin.x + button8Button.frame.width - button4Button.frame.origin.x
            subView.addSubview(newView)
        case 1:
            selectedMethod = 1
            guard let newView = UIView.instanceFromXib(xibName: "SearchByRateView") as? SearchByRateView else { return }
            newView.delegate = self
            newView.frame.size = subView.frame.size
            newView.lowerRateTextField.frame.origin.x = button4Button.frame.origin.x
            newView.lowerRateTextField.frame.size.height = button4Button.frame.height
            newView.upperRateTextField.frame.origin.x = button8Button.frame.origin.x + button8Button.frame.width - newView.lowerRateTextField.frame.width
            newView.upperRateTextField.frame.size = newView.lowerRateTextField.frame.size
            newView.lowerRateTextField.addTarget(self, action: #selector(didEndEditing), for: .editingDidEnd)
            newView.upperRateTextField.addTarget(self, action: #selector(didEndEditing), for: .editingDidEnd)
            subView.addSubview(newView)
        case 2:
            selectedMethod = 2
            guard let newView = UIView.instanceFromXib(xibName: "SearchByNoteView") as? SearchByNoteView else { return }
            newView.delegate = self
            newView.frame.size = subView.frame.size
            newView.noMaxComboButton.frame.origin.x = button4Button.frame.origin.x
            newView.noMaxComboButton.frame.size.width = (button5Button.frame.origin.x - button4Button.frame.origin.x - button4Button.frame.width) + button4Button.frame.width * 2
            newView.noMaxComboButton.frame.size.height = button4Button.frame.height
            newView.perfectPlayButton.frame.origin.x = button6Button.frame.origin.x
            newView.perfectPlayButton.frame.size = newView.noMaxComboButton.frame.size
            newView.noMaxComboButton.addTarget(self, action: #selector(touchUpSearchByNoteButtons), for: .touchUpInside)
            newView.perfectPlayButton.addTarget(self, action: #selector(touchUpSearchByNoteButtons), for: .touchUpInside)
            subView.addSubview(newView)
        default:
            break
        }
        checkValidity()
    }
    
    @objc func touchUpSearchByNoteButtons(_ sender: UIButton){
        checkValidity()
    }
    
    @objc func didEndEditing(_ sender: UITextField){
        checkValidity()
    }
    
    func initializeButtons(){
        for button in buttonButtons{
            UIView.animate(withDuration: 0.3) {
                button?.backgroundColor = UIColor.sub
            }
            button?.layer.borderColor = UIColor.main.cgColor
            button?.layer.borderWidth = 2
        }
    }
    
    func initializeTypes(){
        for button in methodButtons{
            UIView.animate(withDuration: 0.3) {
                button?.backgroundColor = UIColor.sub
            }
            button?.layer.borderColor = UIColor.main.cgColor
            button?.layer.borderWidth = 2
        }
    }
    
    func checkValidity(){
        searchButton.isEnabled = false
        let view = subView.subviews.first
        if view is SearchByLevelView {
            if selectedLevel != 0 {
                searchButton.isEnabled = true
            }
        } else if view is SearchByRateView {
            guard let newView = view as? SearchByRateView else { return }
            guard let lowerText = newView.lowerRateTextField.text else { return }
            guard let upperText = newView.upperRateTextField.text else { return }
            guard let lower = Double(lowerText) else { return }
            guard let upper = Double(upperText) else { return }
            if upper < lower { return }
            searchButton.isEnabled = true
        } else if view is SearchByNoteView {
            if selectedDetailNote != -1 && selectedMethod != -1 && selectedButton != -1 {
                searchButton.isEnabled = true
            }
        } 
    }
}

extension SearchRecordViewController: AKPickerViewDataSource, AKPickerViewDelegate {
    func numberOfItemsInPickerView(_ pickerView: AKPickerView) -> Int {
        return 15
    }
    func pickerView(_ pickerView: AKPickerView, titleForItem item: Int) -> String {
        return "\(levels[item])"
    }
    func pickerView(_ pickerView: AKPickerView, didSelectItem item: Int) {
        self.selectedLevel = levels[item]
        checkValidity()
    }
}

extension SearchRecordViewController: SearchByRateViewDelegate {
    func touchUpDoneButton(_ textFields: [UITextField]) {
        guard let lowerRateTextField = textFields.first else { return }
        guard let upperRateTextField = textFields.last else { return }
        if lowerRateTextField.isFirstResponder {
            lowerRateTextField.resignFirstResponder()
            setTextFieldText(lowerRateTextField)
        } else if upperRateTextField.isFirstResponder {
            upperRateTextField.resignFirstResponder()
            setTextFieldText(upperRateTextField)
        }
    }
    private func setTextFieldText(_ textField: UITextField) {
        guard let text = textField.text else { return }
        guard let value = Double(text) else { return }
        if value >= 100 {
            textField.text = "100"
        }
    }
}

extension SearchRecordViewController: SearchByNoteViewDelegate {
    func touchUpNoteButtons(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            selectedDetailNote = 0
        case 1:
            selectedDetailNote = 1
        default:
            break
        }
    }
}
