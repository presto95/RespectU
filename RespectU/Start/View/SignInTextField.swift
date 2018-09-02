//
//  SignInTextField.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 29..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

class SignInTextField: UITextField {

    @IBInspectable var cornerRadius: CGFloat = 10
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = cornerRadius
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: self.frame.height))
        self.leftViewMode = .always
    }
}
