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
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveUploadData(_:)), name: .didReceiveUploadData, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(errorReceiveUploadData(_:)), name: .errorReceiveUploadData, object: nil)
    }
    
    @objc func touchUpUploadButton(_ sender: UIButton) {
        showIndicator()
    }
    
    @objc func didReceiveUploadData(_ notification: Notification) {
        UIAlertController
            .alert(title: "", message: "Your data has been successfully uploaded.".localized)
            .defaultAction(title: "OK".localized) { [weak self] _ in
                self?.hideIndicator()
                self?.parent?.dismiss(animated: true, completion: nil)
            }
            .present(to: self)
    }
    
    @objc func errorReceiveUploadData(_ notification: Notification) {
        guard let error = notification.userInfo?["error"] as? String else { return }
        UIAlertController
            .alert(title: "", message: error)
            .defaultAction(title: "OK".localized) { [weak self] _ in
                self?.hideIndicator()
            }
            .present(to: self)
    }
    
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
