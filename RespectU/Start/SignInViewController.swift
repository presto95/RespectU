//
//  SignInViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 29..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

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
    
    @objc func touchUpSignInButton(_ sender: UIButton) {
        
    }
    
    @objc func touchUpSignUpButton(_ sender: UIButton) {
        guard let next = UIViewController.instantiate(storyboard: "SignIn", identifier: "SignUpViewController") else { return }
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    @objc func touchUpSkipButton(_ sender: UIButton) {
        guard let next = UIViewController.instantiate(storyboard: "Init", identifier: "InitViewController") else { return }
        UIApplication.shared.keyWindow?.rootViewController = next
    }
}
