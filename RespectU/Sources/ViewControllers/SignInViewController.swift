//
//  SignInViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 29..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import SwiftKeychainWrapper

final class SignInViewController: UIViewController {
  
  @IBOutlet weak var idTextField: UITextField!
  
  @IBOutlet weak var passwordTextField: UITextField!
  
  @IBOutlet weak var signInButton: UIButton!
  
  @IBOutlet weak var signUpButton: UIButton!
  
  @IBOutlet weak var skipButton: UIButton!
  
  @IBOutlet weak var descriptionLabel: UILabel!
  
  var entersAll: Bool {
    guard let isIdTextFieldEmpty = idTextField.text?.isEmpty else { return true }
    guard let isPasswordTextFieldEmpty = passwordTextField.text?.isEmpty else { return true }
    return !(isIdTextFieldEmpty || isPasswordTextFieldEmpty)
  }
  
  var id: String {
    return idTextField.text ?? ""
  }
  
  var password: String {
    return passwordTextField.text ?? ""
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  func setup() {
    idTextField.placeholder = "ID".localized
    passwordTextField.placeholder = "Password".localized
    signInButton.setTitle("Sign In".localized, for: [])
    signUpButton.setTitle("Sign Up".localized, for: [])
    descriptionLabel.text = "Sign in to get more features.".localized
    signInButton.addTarget(self, action: #selector(didTouchUpSignInButton(_:)), for: .touchUpInside)
    signUpButton.addTarget(self, action: #selector(didTouchUpSignUpButton(_:)), for: .touchUpInside)
    skipButton.addTarget(self, action: #selector(didTouchUpSkipButton(_:)), for: .touchUpInside)
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTouchUpSuperview(_:)))
    view.addGestureRecognizer(tapGestureRecognizer)
  }
}

extension SignInViewController {
  
  @objc func didTouchUpSuperview(_ recognizer: UIGestureRecognizer) {
    self.view.endEditing(true)
  }
}

extension SignInViewController {
  
  @objc func didTouchUpSignInButton(_ sender: UIButton) {
    if entersAll {
      APIService.requestSignIn(id: id, password: password) { statusCode, error in
        if let error = error {
          UIAlertController.presentErrorAlert(to: self, error: error.localizedDescription)
          return
        }
        guard let statusCode = statusCode else { return }
        if (200...299).contains(statusCode) {
          DispatchQueue.main.async { [weak self] in
            UIAlertController
              .alert(title: "", message: "Log In Succeeded".localized)
              .action(title: "OK".localized, handler: { _ in
                KeychainWrapper.standard.set(self?.id ?? "", forKey: "id")
                DispatchQueue.main.async {
                  if self?.presentingViewController is UINavigationController {
                    self?.dismiss(animated: true, completion: nil)
                  } else {
                    self?.goToNextViewController()
                  }
                }
                API.requestNickname { response, error in
                  if let error = error {
                    UIAlertController.presentErrorAlert(to: self, error: error.localizedDescription)
                    UserDefaults.standard.set(nil, forKey: "nickname")
                    UserDefaults.standard.synchronize()
                    return
                  }
                  guard let response = response else { return }
                  UserDefaults.standard.set(response.nickname, forKey: "nickname")
                  UserDefaults.standard.synchronize()
                }
                
              })
              .present(to: self)
          }
        } else {
          DispatchQueue.main.async { [weak self] in
            UIAlertController
              .alert(title: "", message: "Log In Failure".localized)
              .action(title: "OK".localized)
              .present(to: self)
          }
        }
      }
    } else {
      UIAlertController
        .alert(title: "", message: "Enter All.".localized)
        .action(title: "OK".localized)
        .present(to: self)
    }
  }
  
  @objc func didTouchUpSignUpButton(_ sender: UIButton) {
    guard let next = UIViewController.instantiate(storyboard: "SignIn", identifier: SignUpViewController.name) else { return }
    self.navigationController?.pushViewController(next, animated: true)
  }
  
  @objc func didTouchUpSkipButton(_ sender: UIButton) {
    if self.presentingViewController is UINavigationController {
      self.dismiss(animated: true, completion: nil)
    } else {
      self.goToNextViewController()
    }
  }
}

extension SignInViewController {
  
  private func goToNextViewController() {
    if TipInfo.fetch().count == 0 {
      guard let next = UIViewController.instantiate(storyboard: "Init", identifier: InitViewController.name) else { return }
      next.modalTransitionStyle = .crossDissolve
      self.present(next, animated: true, completion: nil)
    } else {
      guard let next = UIViewController.instantiate(storyboard: "Performance", identifier: "PerformanceNavigationController") else { return }
      next.modalTransitionStyle = .crossDissolve
      self.present(next, animated: true, completion: nil)
    }
  }
}

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
