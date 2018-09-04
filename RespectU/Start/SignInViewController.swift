//
//  SignInViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 29..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class SignInViewController: UIViewController {

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    var isAllEntered: Bool {
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
        self.idTextField.placeholder = "ID".localized
        self.passwordTextField.placeholder = "Password".localized
        self.signInButton.setTitle("Sign In".localized, for: [])
        self.signUpButton.setTitle("Sign Up".localized, for: [])
        self.descriptionLabel.text = "Sign in to get more features.".localized
        self.signInButton.addTarget(self, action: #selector(touchUpSignInButton(_:)), for: .touchUpInside)
        self.signUpButton.addTarget(self, action: #selector(touchUpSignUpButton(_:)), for: .touchUpInside)
        self.skipButton.addTarget(self, action: #selector(touchUpSkipButton(_:)), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveNickname(_:)), name: .didReceiveNickname, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(errorReceiveNickname(_:)), name: .errorReceiveNickname, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveSignIn(_:)), name: .didReceiveSignIn, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(errorReceiveSignIn(_:)), name: .errorReceiveSignIn, object: nil)
    }
}

extension SignInViewController {
    @objc func didReceiveSignIn(_ notification: Notification) {
        guard let statusCode = notification.userInfo?["statusCode"] as? Int else { return }
        if statusCode == 200 {
            DispatchQueue.main.async { [weak self] in
                UIAlertController
                    .alert(title: "", message: "Log In Succeeded".localized)
                    .defaultAction(title: "OK".localized, handler: { _ in
                        KeychainWrapper.standard.set(self?.id ?? "", forKey: "id")
                        DispatchQueue.main.async {
                            if self?.presentingViewController is UINavigationController {
                                self?.dismiss(animated: true, completion: nil)
                            } else {
                                self?.goToNextViewController()
                            }
                        }
                        API.requestNickname()
                        
                    })
                    .present(to: self)
            }
        } else {
            DispatchQueue.main.async { [weak self] in
                UIAlertController
                    .alert(title: "", message: "Log In Failure".localized)
                    .defaultAction(title: "OK".localized)
                    .present(to: self)
            }
        }
    }
    
    @objc func errorReceiveSignIn(_ notification: Notification) {
        guard let error = notification.userInfo?["error"] as? String else { return }
        DispatchQueue.main.async { [weak self] in
            UIAlertController
                .alert(title: "", message: error)
                .defaultAction(title: "OK".localized)
                .present(to: self)
        }
    }
    
    @objc func didReceiveNickname(_ notification: Notification) {
        guard let userInfo = notification.userInfo?["nickname"] as? NicknameResponse else { return }
        UserDefaults.standard.set(userInfo.nickname, forKey: "nickname")
        UserDefaults.standard.synchronize()
    }
    
    @objc func errorReceiveNickname(_ notification: Notification) {
        UserDefaults.standard.set(nil, forKey: "nickname")
        UserDefaults.standard.synchronize()
    }
}

extension SignInViewController {
    @objc func touchUpSignInButton(_ sender: UIButton) {
        if isAllEntered {
            API.requestSignIn(id: id, password: password)
        } else {
            UIAlertController
                .alert(title: "", message: "모두 입력하세요.".localized)
                .defaultAction(title: "OK".localized)
                .present(to: self)
        }
    }
    
    @objc func touchUpSignUpButton(_ sender: UIButton) {
        guard let next = UIViewController.instantiate(storyboard: "SignIn", identifier: "SignUpViewController") else { return }
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    @objc func touchUpSkipButton(_ sender: UIButton) {
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
            guard let next = UIViewController.instantiate(storyboard: "Init", identifier: "InitViewController") else { return }
            next.modalTransitionStyle = .crossDissolve
            self.present(next, animated: true, completion: nil)
        } else {
            guard let next = UIViewController.instantiate(storyboard: "Performance", identifier: "PerformanceNavigationController") else { return }
            next.modalTransitionStyle = .crossDissolve
            self.present(next, animated: true, completion: nil)
        }
    }
    
    private func presentSuccessAlert() {
        UIAlertController
            .alert(title: "", message: "Log In Succeeded")
            .defaultAction(title: "OK".localized) { [weak self] _ in
                if TipInfo.fetch().count != 0 {
                    guard let controller = UIViewController.instantiate(storyboard: "Performance", identifier: "PerformanceNavigationController") else { return }
                    controller.modalTransitionStyle = .crossDissolve
                    self?.present(controller, animated: true, completion: nil)
                } else {
                    guard let controller = UIViewController.instantiate(storyboard: "Init", identifier: "InitViewController") else { return }
                    controller.modalTransitionStyle = .crossDissolve
                    self?.present(controller, animated: true, completion: nil)
                }
            }
            .present(to: self)
    }
    
    private func presentFailureAlert() {
        UIAlertController
            .alert(title: "", message: "Log In Failed")
            .defaultAction(title: "OK".localized)
            .present(to: self)
    }
}
