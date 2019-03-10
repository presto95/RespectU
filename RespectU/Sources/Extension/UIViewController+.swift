//
//  UIViewController+.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

extension UIViewController {
  
  /// Instantiates the view controller having `identifier` in `storyboard`.
  ///
  /// - Parameters:
  ///   - storyboard: The `storyboard` identifier.
  ///   - identifier: The `identifier` of a view controller.
  ///
  /// - Returns: The instantiated view controller.
  static func instantiate(storyboard: String, identifier: String) -> UIViewController? {
    let viewController = UIStoryboard(name: storyboard, bundle: nil)
      .instantiateViewController(withIdentifier: identifier)
    return viewController
  }
}
