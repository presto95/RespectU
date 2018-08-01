//
//  ActivityIndicatorView.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 1..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

class ActivityIndicatorView: UIView {
    
    static let shared = ActivityIndicatorView(frame: .zero)
    var activityIndicator: UIActivityIndicatorView!
    var containerView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.tag = 100
        containerView.frame.size = CGSize(width: 100, height: 100)
        containerView.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
        containerView.backgroundColor = .lightGray
        self.addSubview(containerView)
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        containerView.addSubview(activityIndicator)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show(to view: UIView) {
        activityIndicator.startAnimating()
        view.addSubview(self)
    }
    
    func hide(from view: UIView) {
        activityIndicator.stopAnimating()
        view.viewWithTag(100)?.removeFromSuperview()
    }
}
