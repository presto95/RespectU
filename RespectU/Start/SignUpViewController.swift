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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.idTextField.placeholder = "ID".localized
        self.passwordTextField.placeholder = "Password".localized
        self.nicknameTextField.placeholder = "Nickname".localized
        self.signUpButton.setTitle("Sign Up".localized, for: [])
        self.signUpButton.addTarget(self, action: #selector(touchUpSignUpButton(_:)), for: .touchUpInside)
    }
    
    @objc func touchUpSignUpButton(_ sender: UIButton) {
        
    }
    
    @IBAction func touchUpPreviousButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
