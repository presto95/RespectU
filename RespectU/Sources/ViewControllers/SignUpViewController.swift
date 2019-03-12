//
//  SignUpViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 29..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

final class SignUpViewController: UIViewController {
  
  private let apiService: APIServiceType = APIService()
  
  @IBOutlet private weak var idTextField: SignInTextField!
  
  @IBOutlet private weak var passwordTextField: SignInTextField!
  
  @IBOutlet private weak var nicknameTextField: SignInTextField!
  
  @IBOutlet private weak var signUpButton: UIButton!
  
  private var isAllTextFieldsEntered: Bool {
    guard let isIdTextFieldEmpty = idTextField.text?.isEmpty else { return true }
    guard let isPasswordTextFieldEmpty = passwordTextField.text?.isEmpty else { return true }
    guard let isNicknameTextFieldEmpty = nicknameTextField.text?.isEmpty else { return true }
    return !(isIdTextFieldEmpty || isPasswordTextFieldEmpty || isNicknameTextFieldEmpty)
  }
  
  private var id: String {
    return idTextField.text ?? ""
  }
  
  private var password: String {
    return passwordTextField.text ?? ""
  }
  
  private var nickname: String {
    return nicknameTextField.text ?? ""
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  private func setup() {
    idTextField.placeholder = L10n.id
    passwordTextField.placeholder = L10n.password
    nicknameTextField.placeholder = L10n.nickname
    signUpButton.setTitle(L10n.signUp, for: [])
    signUpButton.addTarget(self, action: #selector(signUpButtonDidTap(_:)), for: .touchUpInside)
    view.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                     action: #selector(superViewDidTap(_:))))
  }
  
  @IBAction func backButtonDidTap(_ sender: UIButton) {
    navigationController?.popViewController(animated: true)
  }
  
  @objc private func superViewDidTap(_ recognizer: UIGestureRecognizer) {
    self.view.endEditing(true)
  }
  
  @objc private func signUpButtonDidTap(_ sender: UIButton) {
    if isAllTextFieldsEntered {
      apiService
        .requestSignUp(id: id,
                       password: password,
                       nickname: nickname) { [weak self] statusCode, error in
                        guard let self = self else { return }
                        if let error = error {
                          self.present(UIAlertController.makeErrorAlert(error),
                                       animated: true,
                                       completion: nil)
                          return
                        }
                        guard let statusCode = statusCode else { return }
                        let message: String
                        var isRegistered: Bool = false
                        if statusCode == 201 {
                          message = L10n.success
                        } else if statusCode == 409 {
                          message = L10n.itIsRegistered
                          isRegistered = true
                        } else {
                          message = ""
                        }
                        DispatchQueue.main.async {
                          UIAlertController
                            .alert(title: "", message: message)
                            .action(title: L10n.ok) { [weak self] _ in
                              if !isRegistered {
                                self?.navigationController?.popViewController(animated: true)
                              }
                            }
                            .present(to: self)
                        }
                        
      }
    } else {
      UIAlertController
        .alert(title: "", message: L10n.enterAll)
        .action(title: L10n.ok)
        .present(to: self)
    }
  }
}

// MARK: - Conforming UITextFieldDelegate

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
