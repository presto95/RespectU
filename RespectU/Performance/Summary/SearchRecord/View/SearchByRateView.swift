//
//  SearchByRateView.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 19..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

protocol SearchByRateViewDelegate: class {
    func touchUpDoneButton()
}

class SearchByRateView: UIView {

    var delegate: SearchByRateViewDelegate?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var lowerRateTextField: UITextField!
    @IBOutlet weak var upperRateTextField: UITextField!
    lazy var textFields: [UITextField] = {
        return [lowerRateTextField, upperRateTextField]
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.text = "Rate Range (%)".localized
        lowerRateTextField.placeholder = "More Than".localized
        upperRateTextField.placeholder = "Below".localized
        for textField in textFields {
            textField.layer.borderColor = UIColor.main.cgColor
            textField.layer.borderWidth = 2
            textField.keyboardType = .decimalPad
        }
        setToolBar()
    }
    
    @objc func touchUpDoneButton() {
        delegate?.touchUpDoneButton()
//        if lowerRateTextField.isFirstResponder {
//            self.lowerRateTextField.resignFirstResponder()
//            setTextFieldText(self.lowerRateTextField)
//        } else if upperRateTextField.isFirstResponder {
//            self.upperRateTextField.resignFirstResponder()
//            setTextFieldText(self.upperRateTextField)
//        }
    }
    
    private func setToolBar() {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = .main
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(touchUpDoneButton))
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        for textField in textFields {
            textField.inputAccessoryView = toolBar
        }
    }
    
//    private func setTextFieldText(_ textField: UITextField) {
//        guard let text = textField.text else { return }
//        guard let value = Double(text) else { return }
//        if value >= 100 {
//            textField.text = "100"
//        }
//    }
}
