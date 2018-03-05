//
//  Tutorial3ViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

class Tutorial3ViewController: UIViewController {

    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var buttonStart: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        content.text = "Enjoy DJMAX RESPECT with RespectU!".localized
        buttonStart.setTitle("We Respect You", for: .normal)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goToStart(_ sender: UIButton) {
        view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    

}
