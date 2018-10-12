//
//  SignInTextField.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 29..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

class SignInTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        layer.cornerRadius = bounds.height / 2
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        layer.masksToBounds = true
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: self.frame.height))
        leftViewMode = .always
    }
}
