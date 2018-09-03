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
    }
}

extension SignInViewController {
    @objc func touchUpSignInButton(_ sender: UIButton) {
        //세션 생성, 아이디는 키체인에 저장
    }
    
    @objc func touchUpSignUpButton(_ sender: UIButton) {
        guard let next = UIViewController.instantiate(storyboard: "SignIn", identifier: "SignUpViewController") else { return }
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    @objc func touchUpSkipButton(_ sender: UIButton) {
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
}

extension SignInViewController {
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
