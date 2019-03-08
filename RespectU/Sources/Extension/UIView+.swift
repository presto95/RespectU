//
//  UIView+.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

extension UIView {
  
  static func instantiateFromXib(xibName: String) -> UIView {
    guard let view = UINib(nibName: xibName, bundle: nil).instantiate(withOwner: nil, options: nil).first as? UIView else { return UIView() }
    return view
  }
}
