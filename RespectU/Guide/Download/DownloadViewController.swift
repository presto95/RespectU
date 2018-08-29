//
//  DownloadViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 29..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

class DownloadViewController: UIViewController {

    @IBOutlet weak var downloadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.downloadButton.layer.cornerRadius = 10
        self.downloadButton.backgroundColor = .main
        self.downloadButton.addTarget(self, action: #selector(touchUpDownloadButton(_:)), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveDownloadData(_:)), name: .didReceiveDownloadData, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(errorReceiveDownloadData(_:)), name: .errorReceiveDownloadData, object: nil)
    }
    
    @objc func touchUpDownloadButton(_ sender: UIButton) {
        
    }
    
    @objc func didReceiveDownloadData(_ notification: Notification) {
        UIAlertController
            .alert(title: "", message: "Your data has been successfully downloaded.".localized)
            .defaultAction(title: "OK".localized) { [weak self] _ in
                self?.hideIndicator()
                self?.parent?.dismiss(animated: true, completion: nil)
            }
            .present(to: self)
    }
    
    @objc func errorReceiveDownloadData(_ notification: Notification) {
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
