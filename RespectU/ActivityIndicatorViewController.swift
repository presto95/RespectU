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
    @IBOutlet weak var unofficial: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ypos=respectu.frame.origin.y
        UIView.animate(withDuration: 0.7, animations: {
            self.respectu.frame.origin.y = ypos - 80
        }) { (_) in
            UIView.animate(withDuration: 0.3, delay: 0.05, options: .curveEaseIn, animations: {
                self.unofficial.alpha = 1
                self.indicator.alpha = 1
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
