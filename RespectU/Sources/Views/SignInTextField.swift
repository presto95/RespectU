//
//  SignInTextField.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 29..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

/// The sign in text field.
final class SignInTextField: UITextField {
  
  // MARK: - Initializer
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  /// Configures initial settings.
  private func setup() {
    layer.cornerRadius = bounds.height / 2
    layer.borderWidth = 1
    layer.borderColor = UIColor.lightGray.cgColor
    layer.masksToBounds = true
    leftView = UIView(frame: .init(x: 0, y: 0, width: 16, height: bounds.height))
    leftViewMode = .always
  }
}
