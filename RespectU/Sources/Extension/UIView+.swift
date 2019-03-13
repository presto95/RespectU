//
//  UIView+.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

extension UIView {
  
  /// Instantiates the view named `xibName`.
  ///
  /// - Parameter xibName: The name of xib file.
  ///
  /// - Returns: The instantiated view.
  static func instantiateFromXIB(xibName: String) -> UIView? {
    return UINib(nibName: xibName, bundle: nil)
      .instantiate(withOwner: nil, options: nil).first as? UIView
  }
}
