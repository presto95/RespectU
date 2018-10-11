//
//  SearchByConditionViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 19..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

class SearchRecordViewController: UIViewController {

    let levels = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
    var selectedButtonIndex: Int = -1
    var selectedLevelIndex: Int = -1
    var selectedNoteDetailIndex: Int = -1
    var selectedMethodIndex: Int = -1
    @IBOutlet weak var button4Button: UIButton!
    @IBOutlet weak var button5Button: UIButton!
    @IBOutlet weak var button6Button: UIButton!
    @IBOutlet weak var button8Button: UIButton!
    @IBOutlet weak var searchByLevelButton: UIButton!
    @IBOutlet weak var searchByRateButton: UIButton!
    @IBOutlet weak var searchByNoteButton: UIButton!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    var buttonButtons = [UIButton?]()
    var methodButtons = [UIButton?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchByLevelButton.setTitle("Level".localized, for: .normal)
        searchByRateButton.setTitle("Rate".localized, for: .normal)
        searchByNoteButton.setTitle("Note".localized, for: .normal)
        searchButton.setTitle("Enter all conditions".localized, for: .disabled)
        searchButton.setTitle("Search".localized, for: .normal)
        buttonButtons = [button4Button, button5Button, button6Button, button8Button]
        methodButtons = [searchByLevelButton, searchByRateButton, searchByNoteButton]
        initializeButtons()
        initializeMethods()
    }
    
    @IBAction func didTouchUpSearchButton(_ sender: UIButton) {
        guard let controller = UIViewController.instantiate(storyboard: "Performance", identifier: SearchRecordDetailViewController.classNameToString) as? SearchRecordDetailViewController else { return }
        controller.buttonIndex = { () -> Int in
            for index in 0..<4 {
                guard let button = buttonButtons[index] else { return -1 }
                if button.isSelected {
                    return index
                }
            }
            return -1
        }()
        controller.methodIndex = { () -> Int in
            for index in 0..<3 {
                guard let button = methodButtons[index] else { return -1 }
                if button.isSelected {
                    return index
                }
            }
            return -1
        }()
        if searchByLevelButton.isSelected {
            controller.levelIndex = selectedLevelIndex
        } else if searchByRateButton.isSelected {
            guard let rateView = subView.subviews.first as? SearchByRateView else { return }
            let lowerRate = Double(rateView.lowerRateTextField.text ?? "") ?? 0
            let upperRate = Double(rateView.upperRateTextField.text ?? "") ?? 0
            controller.lowerRange = lowerRate
            controller.upperRange = upperRate
        } else if searchByNoteButton.isSelected {
            guard let noteView = subView.subviews.first as? SearchByNoteView else { return }
            controller.noteDetailIndex = { () -> Int in
                if noteView.noMaxComboButton.isSelected {
                    return 0
                } else {
                    return 1
                }
            }()
        }
        self.present(controller, animated: true)
    }
    
    @IBAction func didTouchUpButtons(_ sender: UIButton) {
        initializeButtons()
        for button in buttonButtons {
            button?.isSelected = false
        }
        sender.isSelected = true
        UIView.animate(withDuration: 0.3) {
            sender.backgroundColor = .main
        }
        switch sender.tag {
        case 0:
            selectedButtonIndex = 0
        case 1:
            selectedButtonIndex = 1
        case 2:
            selectedButtonIndex = 2
        case 3:
            selectedButtonIndex = 3
        default:
            break
        }
        checkValidity()
    }
    
    @IBAction func didTouchUpMethodButtons(_ sender: UIButton) {
        let view = subView.subviews.first
        if view is SearchByNoteView {
            selectedNoteDetailIndex = -1
        }
        if subView.subviews.count != 0 {
            subView.subviews.first?.removeFromSuperview()
        }
        initializeMethods()
        for type in methodButtons {
            type?.isSelected = false
        }
        sender.isSelected = true
        UIView.animate(withDuration: 0.3) {
            sender.backgroundColor = .main
        }
        switch sender.tag {
        case 0:
            selectedMethodIndex = 0
            guard let newView = UIView.instantiateFromXib(xibName: "SearchByLevelView") as? SearchByLevelView else { return }
            newView.pickerView.delegate = self
            newView.pickerView.dataSource = self
            subView.addSubview(newView)
            newView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                newView.topAnchor.constraint(equalTo: subView.topAnchor),
                newView.leftAnchor.constraint(equalTo: subView.leftAnchor, constant: 16),
                newView.rightAnchor.constraint(equalTo: subView.rightAnchor, constant: -16),
                newView.heightAnchor.constraint(equalToConstant: 100)
                ])
        case 1:
            selectedMethodIndex = 1
            guard let newView = UIView.instantiateFromXib(xibName: "SearchByRateView") as? SearchByRateView else { return }
            newView.delegate = self
            newView.lowerRateTextField.addTarget(self, action: #selector(didEndEditing), for: .editingDidEnd)
            newView.upperRateTextField.addTarget(self, action: #selector(didEndEditing), for: .editingDidEnd)
            subView.addSubview(newView)
            newView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                newView.topAnchor.constraint(equalTo: subView.topAnchor),
                newView.leftAnchor.constraint(equalTo: subView.leftAnchor),
                newView.rightAnchor.constraint(equalTo: subView.rightAnchor),
                newView.heightAnchor.constraint(equalToConstant: 100)
                ])
        case 2:
            selectedMethodIndex = 2
            guard let newView = UIView.instantiateFromXib(xibName: "SearchByNoteView") as? SearchByNoteView else { return }
            newView.delegate = self
            newView.noMaxComboButton.addTarget(self, action: #selector(touchUpSearchByNoteButtons), for: .touchUpInside)
            newView.perfectPlayButton.addTarget(self, action: #selector(touchUpSearchByNoteButtons), for: .touchUpInside)
            subView.addSubview(newView)
            newView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                newView.topAnchor.constraint(equalTo: subView.topAnchor),
                newView.leftAnchor.constraint(equalTo: subView.leftAnchor),
                newView.rightAnchor.constraint(equalTo: subView.rightAnchor),
                newView.heightAnchor.constraint(equalToConstant: 100)
                ])
        default:
            break
        }
        checkValidity()
    }
    
    @IBAction func didTouchUpCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func touchUpSearchByNoteButtons(_ sender: UIButton) {
        checkValidity()
    }
    
    @objc func didEndEditing(_ sender: UITextField) {
        checkValidity()
    }
}

extension SearchRecordViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 15
    }
}

extension SearchRecordViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(self.levels[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedLevelIndex = row
        checkValidity()
    }
}

extension SearchRecordViewController: SearchByRateViewDelegate {
    func didTouchUpDoneButton(_ textFields: [UITextField]) {
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
    func didTouchUpNoteButtons(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            selectedNoteDetailIndex = 0
        case 1:
            selectedNoteDetailIndex = 1
        default:
            break
        }
    }
}

extension SearchRecordViewController {
    private func initializeButtons() {
        for button in buttonButtons {
            UIView.animate(withDuration: 0.3) {
                button?.backgroundColor = .sub
            }
            button?.layer.borderColor = UIColor.main.cgColor
            button?.layer.borderWidth = 2
        }
    }
    
    private func initializeMethods() {
        for button in methodButtons {
            UIView.animate(withDuration: 0.3) {
                button?.backgroundColor = .sub
            }
            button?.layer.borderColor = UIColor.main.cgColor
            button?.layer.borderWidth = 2
        }
    }
    
    private func checkValidity() {
        self.searchButton.isEnabled = false
        let view = subView.subviews.first
        switch view {
        case is SearchByLevelView:
            if selectedLevelIndex != -1, selectedMethodIndex != -1, selectedButtonIndex != -1 {
                self.searchButton.isEnabled = true
            }
        case is SearchByRateView:
            guard let newView = view as? SearchByRateView else { return }
            guard let lowerText = newView.lowerRateTextField.text else { return }
            guard let upperText = newView.upperRateTextField.text else { return }
            guard let lower = Double(lowerText) else { return }
            guard let upper = Double(upperText) else { return }
            if upper > lower {
                self.searchButton.isEnabled = true
            }
        case is SearchByNoteView:
            if selectedNoteDetailIndex != -1, selectedMethodIndex != -1, selectedButtonIndex != -1 {
                self.searchButton.isEnabled = true
            }
        default:
            break
        }
    }
}
