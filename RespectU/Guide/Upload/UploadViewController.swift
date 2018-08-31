//
//  SynchronizeViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 29..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

class UploadViewController: UIViewController {

    @IBOutlet weak var uploadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.uploadButton.layer.cornerRadius = 10
        self.uploadButton.backgroundColor = .main
        self.uploadButton.addTarget(self, action: #selector(touchUpUploadButton(_:)), for: .touchUpInside)
    }
    
    @objc func touchUpUploadButton(_ sender: UIButton) {
        showIndicator()
    }
    
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
