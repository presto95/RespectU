//
//  SearchByRateView.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 19..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

protocol SearchByRateViewDelegate: class {
  func didTouchUpDoneButton(_ textFields: [UITextField])
}

final class SearchByRateView: UIView {
  
  weak var delegate: SearchByRateViewDelegate?
  
  @IBOutlet weak var lowerRateTextField: UITextField!
  
  @IBOutlet weak var upperRateTextField: UITextField!
  
  lazy var textFields: [UITextField] = {
    return [lowerRateTextField, upperRateTextField]
  }()
  
  override func awakeFromNib() {
    super.awakeFromNib()
    lowerRateTextField.placeholder = "More Than".localized
    upperRateTextField.placeholder = "Below".localized
    for textField in textFields {
      textField.layer.borderColor = UIColor.main.cgColor
      textField.layer.borderWidth = 1
      textField.layer.cornerRadius = textField.bounds.height / 2
      textField.keyboardType = .decimalPad
    }
    setToolBar()
  }
  
  @objc func didTouchUpDoneButton() {
    delegate?.didTouchUpDoneButton(textFields)
  }
}

extension SearchByRateView {
  
  private func setToolBar() {
    let toolBar = UIToolbar()
    toolBar.barStyle = .default
    toolBar.isTranslucent = true
    toolBar.tintColor = .main
    let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTouchUpDoneButton))
    toolBar.setItems([flexibleSpace, doneButton], animated: false)
    toolBar.isUserInteractionEnabled = true
    toolBar.sizeToFit()
    for textField in textFields {
      textField.inputAccessoryView = toolBar
    }
  }
}
