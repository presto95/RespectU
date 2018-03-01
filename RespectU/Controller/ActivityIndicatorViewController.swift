//
//  ActivityIndicatorViewController.swift
//  RespectU
//
//  Created by Presto on 2017. 10. 15..
//  Copyright © 2017년 Presto. All rights reserved.
//

import UIKit

class ActivityIndicatorViewController: UIViewController {
    @IBOutlet weak var respectu: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.respectu.alpha = 0
        UIView.animate(withDuration: 0.5, animations: {
        }) { (_) in
            UIView.animate(withDuration: 0.5, delay: 0.05, options: .curveEaseIn, animations: {
                self.respectu.alpha = 1
                
            })
        }
        _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
            
            let storyboard = self.storyboard
            let ivc = storyboard?.instantiateViewController(withIdentifier: "TabBarController")
            ivc?.modalTransitionStyle = .crossDissolve
            self.present(ivc!, animated: true, completion: nil)
            // do stuff 42 seconds later
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
