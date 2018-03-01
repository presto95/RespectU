//
//  PerformanceViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 1..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class PerformanceViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height + 500)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        if(Auth.auth().currentUser == nil){
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            present(controller, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func goToNext(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Guide", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "GuideViewController") as! GuideViewController
        navigationController?.pushViewController(controller, animated: true)
    }
    @IBAction func recordPerformance(_ sender: UIButton) {
        
    }
}
