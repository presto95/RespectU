//
//  CommonButton.swift
//  RespectU
//
//  Created by Presto on 11/10/2018.
//  Copyright © 2018 Presto. All rights reserved.
//

import UIKit

/// The custom button used throughout the application.
final class RUButton: UIButton {
  
  // MARK: Initializer
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    configure()
  }
  
  // MARK: Method
  
  /// Configures default settings.
  private func configure() {
    layer.cornerRadius = bounds.height / 2
    layer.borderWidth = 1
    layer.borderColor = UIColor.main.cgColor
    titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    setTitleColor(.main, for: [])
  }
}
