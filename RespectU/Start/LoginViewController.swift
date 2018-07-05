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

    @IBOutlet weak var buttonSkip: UIButton!
    @IBOutlet weak var labelExplanation: UILabel!
    @IBOutlet weak var buttonLogin: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonLogin.style = .wide
        buttonLogin.colorScheme = .light
        buttonSkip.setTitle("SKIP".localized, for: .normal)
        labelExplanation.text = "You must be logged in to use the ranking system.".localized
        GIDSignIn.sharedInstance().uiDelegate = self
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if(user != nil){
                self.dismiss(animated: true, completion: nil)
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func login(_ sender: GIDSignInButton) {
        GIDSignIn.sharedInstance().signIn()
    }
    @IBAction func skip(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
