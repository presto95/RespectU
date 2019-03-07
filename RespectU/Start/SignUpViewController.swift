//
//  SignUpViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 29..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

final class SignUpViewController: UIViewController {
  
  @IBOutlet weak var idTextField: SignInTextField!
  
  @IBOutlet weak var passwordTextField: SignInTextField!
  
  @IBOutlet weak var nicknameTextField: SignInTextField!
  
  @IBOutlet weak var signUpButton: UIButton!
  
  var entersAll: Bool {
    guard let isIdTextFieldEmpty = idTextField.text?.isEmpty else { return true }
    guard let isPasswordTextFieldEmpty = passwordTextField.text?.isEmpty else { return true }
    guard let isNicknameTextFieldEmpty = nicknameTextField.text?.isEmpty else { return true }
    return !(isIdTextFieldEmpty || isPasswordTextFieldEmpty || isNicknameTextFieldEmpty)
  }
  
  var id: String {
    return idTextField.text ?? ""
  }
  
  var password: String {
    return passwordTextField.text ?? ""
  }
  
  var nickname: String {
    return nicknameTextField.text ?? ""
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  func setup() {
    idTextField.placeholder = "ID".localized
    passwordTextField.placeholder = "Password".localized
    nicknameTextField.placeholder = "Nickname".localized
    signUpButton.setTitle("Sign Up".localized, for: [])
    signUpButton.addTarget(self, action: #selector(didTouchUpSignUpButton(_:)), for: .touchUpInside)
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTouchUpSuperview(_:)))
    view.addGestureRecognizer(tapGestureRecognizer)
  }
  
  @IBAction func didTouchUpPreviousButton(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
}

extension SignUpViewController {
  
  @objc func didTouchUpSuperview(_ recognizer: UIGestureRecognizer) {
    self.view.endEditing(true)
  }
  
  @objc func didTouchUpSignUpButton(_ sender: UIButton) {
    if entersAll {
      API.requestSignUp(id: id, password: password, nickname: nickname) { statusCode, error in
        if let error = error {
          UIAlertController.presentErrorAlert(to: self, error: error.localizedDescription)
          return
        }
        guard let statusCode = statusCode else { return }
        let message: String
        var isRegistered: Bool = false
        if statusCode == 201 {
          message = "Success".localized
        } else if statusCode == 409 {
          message = "It is registered.".localized
          isRegistered = true
        } else {
          message = ""
        }
        DispatchQueue.main.async {
          UIAlertController
            .alert(title: "", message: message)
            .action(title: "OK".localized) { [weak self] _ in
              if !isRegistered {
                self?.navigationController?.popViewController(animated: true)
              }
            }
            .present(to: self)
        }
        
      }
    } else {
      UIAlertController
        .alert(title: "", message: "Enter All.".localized)
        .action(title: "OK".localized)
        .present(to: self)
    }
  }
}

extension SignUpViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField.tag == 0 {
      textField.resignFirstResponder()
      passwordTextField.becomeFirstResponder()
    } else if textField.tag == 1 {
      textField.resignFirstResponder()
      nicknameTextField.becomeFirstResponder()
    } else {
      textField.endEditing(true)
    }
    return true
  }
}
