//
//  LoginViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 1..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import Firebase
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
                self.goToTutorialOrDismiss()
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
        goToTutorialOrDismiss()
    }
    func goToTutorialOrDismiss(){
        UserDefaults.standard.set(false, forKey: "firstExecution2")
        if(!UserDefaults.standard.bool(forKey: "firstExecution2")){
            UserDefaults.standard.set(true, forKey: "firstExecution2")
            let storyboard = UIStoryboard(name: "Tutorial", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "TutorialViewController") as! TutorialViewController
            controller.modalTransitionStyle = .crossDissolve
            present(controller, animated: true, completion: nil)
        } else {
            dismiss(animated: true, completion: nil)
        }
        
    }
}
