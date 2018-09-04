//
//  SynchronizeViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 29..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

class UploadViewController: UIViewController {

    @IBOutlet weak var uploadLabel: UILabel!
    @IBOutlet weak var uploadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.uploadButton.layer.cornerRadius = 10
        self.uploadButton.backgroundColor = .main
        self.uploadLabel.text = "Store recorded performance information on the server.".localized
        self.uploadButton.setTitle("Upload".localized, for: [])
        self.uploadButton.addTarget(self, action: #selector(touchUpUploadButton(_:)), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(errorReceiveUploadRecords(_:)), name: .errorReceiveUploadRecords, object: nil)
    }
    
    @objc func errorReceiveUploadRecords(_ notification: Notification) {
        presentFailureAlert()
    }
    
    @objc func touchUpUploadButton(_ sender: UIButton) {
        showIndicator()
        let results = NewRecordInfo.fetch()
        for result in results {
            API.uploadRecords(result)
        }
    }
    
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension UploadViewController {
    private func presentFailureAlert() {
        UIAlertController
            .alert(title: "", message: "Network Error".localized)
            .action(title: "OK".localized) { [weak self] _ in
                self?.hideIndicator()
            }
            .present(to: self)
    }
}
