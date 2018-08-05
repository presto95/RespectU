//
//  LoginViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 1..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInUIDelegate {

    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var explanationLabel: UILabel!
    @IBOutlet weak var loginButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginButton.style = .wide
        self.loginButton.colorScheme = .light
        self.skipButton.setTitle("SKIP".localized, for: .normal)
        self.explanationLabel.text = "You must be logged in to use the ranking system.".localized
        self.loginButton.addTarget(self, action: #selector(touchUpLoginButton(_:)), for: .touchUpInside)
        self.skipButton.addTarget(self, action: #selector(touchUpSkipButton(_:)), for: .touchUpInside)
        GIDSignIn.sharedInstance().uiDelegate = self
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if(user != nil){
                self.dismiss(animated: true, completion: nil)
            }
        }
    }

    @objc func touchUpLoginButton(_ sender: GIDSignInButton) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    @objc func touchUpSkipButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
