//
//  IndicatorView.swift
//  FruitSchool
//
//  Created by Presto on 05/10/2018.
//  Copyright © 2018 YAPP. All rights reserved.
//

import UIKit

class IndicatorView: UIView {

    private static let _shared = UIView.instantiateFromXib(xibName: "IndicatorView") as? IndicatorView
    static let shared: IndicatorView = {
        guard let shared = _shared else { return IndicatorView() }
        return shared
    }()
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 10
    }
    
    func showIndicator(message: String? = nil) {
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            self.frame = UIScreen.main.bounds
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            self.messageLabel.text = message
            self.activityIndicatorView.startAnimating()
            UIApplication.shared.keyWindow?.addSubview(self)
        }
    }
    
    func hideIndicator() {
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            self.activityIndicatorView.stopAnimating()
            self.removeFromSuperview()
        }
    }
}
