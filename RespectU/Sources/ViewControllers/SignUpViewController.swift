//
//  SignUpViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 29..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

/// The sign up view controller.
final class SignUpViewController: UIViewController {
  
  /// The api service.
  private let apiService: APIServiceType = APIService()
  
  /// The id text field.
  @IBOutlet private weak var idTextField: SignInTextField!
  
  /// The password text field.
  @IBOutlet private weak var passwordTextField: SignInTextField!
  
  /// The nickname text field.
  @IBOutlet private weak var nicknameTextField: SignInTextField!
  
  /// The sign up button.
  @IBOutlet private weak var signUpButton: UIButton!
  
  /// The boolean value indicating whether all the textfields have a value.
  private var isAllTextFieldsEntered: Bool {
    guard let isIdTextFieldEmpty = idTextField.text?.isEmpty else { return true }
    guard let isPasswordTextFieldEmpty = passwordTextField.text?.isEmpty else { return true }
    guard let isNicknameTextFieldEmpty = nicknameTextField.text?.isEmpty else { return true }
    return !(isIdTextFieldEmpty || isPasswordTextFieldEmpty || isNicknameTextFieldEmpty)
  }
  
  /// The id.
  private var id: String {
    return idTextField.text ?? ""
  }
  
  /// The password.
  private var password: String {
    return passwordTextField.text ?? ""
  }
  
  /// The nickname.
  private var nickname: String {
    return nicknameTextField.text ?? ""
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
  }
  
  /// Configures initial settings.
  private func configure() {
    idTextField.placeholder = L10n.id
    passwordTextField.placeholder = L10n.password
    nicknameTextField.placeholder = L10n.nickname
    signUpButton.setTitle(L10n.signUp, for: [])
    signUpButton.addTarget(self, action: #selector(signUpButtonDidTap(_:)), for: .touchUpInside)
    view.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                     action: #selector(superViewDidTap(_:))))
  }
  
  /// Tells the `sender` that the back button is tapped.
  @IBAction private func backButtonDidTap(_ sender: UIButton) {
    navigationController?.popViewController(animated: true)
  }
  
  /// Tells the `recognizer` that the super view is tapped.
  @objc private func superViewDidTap(_ recognizer: UIGestureRecognizer) {
    view.endEditing(true)
  }
  
  /// Tells the `sender` that the sign up button is tapped.
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
