//
//  ManualViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 6..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import WebKit

class ManualViewController: UIViewController {

    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "http://djmaxrespect.com/manual.html")
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "cancelButton"), for: .normal)
        button.frame = CGRect(x: view.frame.width - 60, y: 40, width: 40, height: 40)
        button.addTarget(self, action: #selector(touchUpCancelButton(_:)), for: .touchUpInside)
        webView.addSubview(button)
    }
    
    @objc func touchUpCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ManualViewController: WKUIDelegate {
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        let frame = CGRect(x: 0, y: 80, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 80)
        webView = WKWebView(frame: frame, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
}
