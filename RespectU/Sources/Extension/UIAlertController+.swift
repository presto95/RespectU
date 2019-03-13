//
//  UIAlertController+.swift
//  RespectU
//
//  Created by Presto on 2018. 6. 28..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

extension UIAlertController {
  
  // MARK: Alert
  
  /// Creates an `UIAlertController`.
  ///
  /// - Parameters:
  ///   - title:    The `title` of created `UIAlertController`.
  ///   - message:  The `message` of created `UIAlertController`.
  ///
  /// - Returns: The created `UIAlertController`.
  static func alert(title: String?, message: String?) -> UIAlertController {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    return alert
  }
  
  // MARK: Action
  
  /// Adds `UIAlertAction` to the created `UIAlertController`.
  ///
  /// - Parameters:
  ///   - title:      The `title` of created `UIAlertAction`.
  ///   - style:      The `style` of created `UIAlertAction`.
  ///                 The default value is `UIAlertAction.Style.default`.
  ///   - completion: The `completion` handler of created `UIAlertAction`.
  ///                 The default value is `nil`.
  ///
  /// - Returns: The `UIAlertController` with the created `UIAlertAction`.
  @discardableResult
  func action(title: String?,
              style: UIAlertAction.Style = .default,
              completion: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
    let action = UIAlertAction(title: title, style: style, handler: completion)
    addAction(action)
    return self
  }
  
  /// Adds `UITextField` to the created `UIAlertController`.
  ///
  /// - Parameters:
  ///   - handler: The `configuration handler` of created `UITextField`.
  ///              The default value is `nil`.
  ///
  /// - Returns: The `UIAlertController` with the created `UITextField`.
  @discardableResult
  func textField(
    configurationHandler handler: ((UITextField) -> Void)? = nil
  ) -> UIAlertController {
    addTextField(configurationHandler: handler)
    return self
  }
  
  // MARK: Present
  
  /// Presents the `UIAlertController` to `viewController`.
  ///
  /// - Parameters:
  ///   - viewController: The `viewController` presenting the `UIAlertController`.
  ///   - completion:     The `completion` handler of the `UIAlertController`.
  ///                     The default value is `nil`.
  func present(to viewController: UIViewController?, completion: (() -> Void)? = nil) {
    viewController?.present(self, animated: true, completion: completion)
  }
  
  // MARK: Error Alert
  
  /// Makes an `UIAlertController` that can presents an error description.
  ///
  /// - Parameters:
  ///   - error:      The `Error`.
  ///   - completion: The `completion` handler of the `UIAlertController`.
  ///                 The default value is `nil`.
  ///
  /// - Returns: The created `UIAlertController`.
  static func makeErrorAlert(_ error: Error,
                             completion: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
    return UIAlertController
      .alert(title: "", message: error.localizedDescription)
      .action(title: L10n.ok, completion: completion)
  }
}
