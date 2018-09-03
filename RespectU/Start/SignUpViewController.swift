//
//  SignUpViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 29..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var idTextField: SignInTextField!
    @IBOutlet weak var passwordTextField: SignInTextField!
    @IBOutlet weak var nicknameTextField: SignInTextField!
    @IBOutlet weak var signUpButton: SignInButton!
    var isAllEntered: Bool {
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
        self.idTextField.placeholder = "ID".localized
        self.passwordTextField.placeholder = "Password".localized
        self.nicknameTextField.placeholder = "Nickname".localized
        self.signUpButton.setTitle("Sign Up".localized, for: [])
        self.signUpButton.addTarget(self, action: #selector(touchUpSignUpButton(_:)), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveSignUp(_:)), name: .didReceiveSignUp, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(errorReceiveSignUp(_:)), name: .errorReceiveSignUp, object: nil)
    }
    
    @objc func didReceiveSignUp(_ notification: Notification) {
        guard let statusCode = notification.userInfo?["statusCode"] as? Int else { return }
        let message: String
        var isRegistered: Bool = false
        if statusCode == 201 {
            message = "Success".localized
        } else if statusCode == 409 {
            message = "등록된 사용자입니다.".localized
            isRegistered = true
        } else {
            message = ""
        }
        DispatchQueue.main.async {
            UIAlertController
                .alert(title: "", message: message)
                .defaultAction(title: "OK".localized) { [weak self] (action) in
                    if !isRegistered {
                        self?.navigationController?.popViewController(animated: true)
                    }
                }
                .present(to: self)
        }
    }
    
    @objc func errorReceiveSignUp(_ notification: Notification) {
        guard let userInfo = notification.userInfo?["error"] as? String else { return }
        DispatchQueue.main.async {
            UIAlertController
                .alert(title: "", message: userInfo)
                .defaultAction(title: "OK".localized) { [weak self] _ in
                    self?.hideIndicator()
                }
                .present(to: self)
        }
    }
    
    @objc func touchUpSignUpButton(_ sender: UIButton) {
        if isAllEntered {
            API.requestSignUp(id: id, password: password, nickname: nickname)
        } else {
            UIAlertController
                .alert(title: "", message: "모두 입력하세요.".localized)
                .defaultAction(title: "OK".localized)
                .present(to: self)
        }
    }
    
    @IBAction func touchUpPreviousButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
