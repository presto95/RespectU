//
//  SignInViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 29..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import SwiftKeychainWrapper

/// The sign in view controller.
final class SignInViewController: UIViewController {
  
  /// The api service.
  private let apiService: APIServiceType = APIService()
  
  /// The id text field.
  @IBOutlet private weak var idTextField: UITextField!
  
  /// The password text field.
  @IBOutlet private weak var passwordTextField: UITextField!
  
  /// The sign in button.
  @IBOutlet private weak var signInButton: UIButton!
  
  /// The sign up button.
  @IBOutlet private weak var signUpButton: UIButton!
  
  /// The skip button.
  @IBOutlet private weak var skipButton: UIButton!
  
  /// The description label.
  @IBOutlet private weak var descriptionLabel: UILabel!
  
  /// The booealn value indicating whether all the text fields have value.
  private var isAllTextFieldsEntered: Bool {
    guard let isIdTextFieldEmpty = idTextField.text?.isEmpty else { return true }
    guard let isPasswordTextFieldEmpty = passwordTextField.text?.isEmpty else { return true }
    return !(isIdTextFieldEmpty || isPasswordTextFieldEmpty)
  }
  
  /// The id.
  private var id: String {
    return idTextField.text ?? ""
  }
  
  /// The password.
  private var password: String {
    return passwordTextField.text ?? ""
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
  }
  
  /// Configures initial settings.
  private func configure() {
    idTextField.placeholder = L10n.id
    passwordTextField.placeholder = L10n.password
    signInButton.setTitle(L10n.signIn, for: [])
    signUpButton.setTitle(L10n.signUp, for: [])
    descriptionLabel.text = L10n.signInToGetMoreFeatures
    signInButton.addTarget(self, action: #selector(signInButtonDidTap(_:)), for: .touchUpInside)
    signUpButton.addTarget(self, action: #selector(signUpButtonDidTap(_:)), for: .touchUpInside)
    skipButton.addTarget(self, action: #selector(skipButtonDidTap(_:)), for: .touchUpInside)
    view.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                     action: #selector(superViewDidTap(_:))))
  }
  
  /// Tells the `sender` that the sign in button is tapped.
  @objc private func signInButtonDidTap(_ sender: UIButton) {
    if isAllTextFieldsEntered {
      apiService.requestSignIn(id: id, password: password) { [weak self] statusCode, error in
        guard let self = self else { return }
        if let error = error {
          self.present(UIAlertController.makeErrorAlert(error), animated: true, completion: nil)
          return
        }
        guard let statusCode = statusCode else { return }
        if (200...299).contains(statusCode) {
          DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            UIAlertController
              .alert(title: "", message: L10n.logInSucceeded)
              .action(title: L10n.ok) { _ in
                KeychainWrapper.standard.set(self.id, forKey: "id")
                DispatchQueue.main.async {
                  if self.presentingViewController is UINavigationController {
                    self.dismiss(animated: true, completion: nil)
                  } else {
                    self.presentNextViewController()
                  }
                }
                self.apiService.requestNickname { response, error in
                  if let error = error {
                    self.present(UIAlertController.makeErrorAlert(error),
                                 animated: true,
                                 completion: nil)
                    UserDefaults.standard.do {
                      $0.set(nil, forKey: "nickname")
                      $0.synchronize()
                    }
                    return
                  }
                  guard let response = response else { return }
                  UserDefaults.standard.do {
                    $0.set(response.nickname, forKey: "nickname")
                    $0.synchronize()
                  }
                }
              }
              .present(to: self)
          }
        } else {
          DispatchQueue.main.async { [weak self] in
            UIAlertController
              .alert(title: "", message: L10n.logInFailure)
              .action(title: L10n.ok)
              .present(to: self)
          }
        }
      }
    } else {
      UIAlertController
        .alert(title: "", message: L10n.enterAll)
        .action(title: L10n.ok)
        .present(to: self)
    }
  }
  
  /// Tells the `sender` that the sign up button is tapped.
  @objc private func signUpButtonDidTap(_ sender: UIButton) {
    let controller = StoryboardScene.SignIn.signInViewController.instantiate()
    navigationController?.pushViewController(controller, animated: true)
  }
  
  /// Tells the `sender` that the skip button is tapped.
  @objc private func skipButtonDidTap(_ sender: UIButton) {
    if presentingViewController is UINavigationController {
      dismiss(animated: true, completion: nil)
    } else {
      presentNextViewController()
    }
  }
  
  /// Tells the `recognizer` that the super view is tapped.
  @objc private func superViewDidTap(_ recognizer: UIGestureRecognizer) {
    view.endEditing(true)
  }
}

// MARK: - Conforming UITextFieldDelegate

extension SignInViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField.tag == 0 {
      textField.resignFirstResponder()
      passwordTextField.becomeFirstResponder()
    } else {
      textField.endEditing(true)
    }
    return true
  }
}

// MARK: - Private Method

private extension SignInViewController {
  
  /// Presents next view controller.
  func presentNextViewController() {
    if TipInfo.fetch().count == 0 {
      let controller = StoryboardScene.Init.initViewController.instantiate().then {
        $0.modalTransitionStyle = .crossDissolve
      }
      present(controller, animated: true, completion: nil)
    } else {
      let controller = StoryboardScene.Performance.performanceNavigationController.instantiate()
        .then {
          $0.modalTransitionStyle = .crossDissolve
      }
      present(controller, animated: true, completion: nil)
    }
  }
}
