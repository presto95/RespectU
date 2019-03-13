//
//  SearchByRateView.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 19..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

/// The `protocol` that defines delegate methods of the `SearchByRatingView`.
protocol SearchByRatingViewDelegate: class {
  
  /// Tells the delegate that the done button is tapped.
  ///
  /// - Parameters:
  ///   - view:       The view requesting this information.
  ///   - button:     The button which is tapped.
  ///   - textFields: The text fields that the ratings are entered.
  func searchByRatingView(_ view: SearchByRatingView,
                          didTapDoneButton button: UIButton,
                          with textFields: [UITextField])
}

/// The search by rating view.
final class SearchByRatingView: UIView {
  
  /// The object that acts as the delegate of the `SearchByRatingView`.
  weak var delegate: SearchByRatingViewDelegate?
  
  /// The text field that takes lower rating.
  @IBOutlet weak var lowerRatingTextField: UITextField!
  
  /// The text field that takes upper rating.
  @IBOutlet weak var upperRatingTextField: UITextField!
  
  /// The all text fields.
  private var textFields: [UITextField] {
    return [lowerRatingTextField, upperRatingTextField]
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configure()
  }
  
  /// Configures initial settings.
  private func configure() {
    lowerRatingTextField.placeholder = L10n.moreThan
    upperRatingTextField.placeholder = L10n.below
    textFields.forEach {
      $0.layer.borderColor = UIColor.main.cgColor
      $0.layer.borderWidth = 1
      $0.layer.cornerRadius = $0.bounds.height / 2
      $0.keyboardType = .decimalPad
    }
    let toolBar = makeToolBar()
    textFields.forEach { $0.inputAccessoryView = toolBar }
  }
  
  /// Tells the `sender` that the done button is tapped.
  @objc private func doneButtonDidTap(_ sender: UIButton) {
    delegate?.searchByRatingView(self, didTapDoneButton: sender, with: textFields)
  }
  
  /// Creates the tool bar.
  ///
  /// - Returns: The created tool bar.
  private func makeToolBar() -> UIToolbar {
    let flexibleSpace
      = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                     target: self,
                                     action: #selector(doneButtonDidTap(_:)))
    let toolBar = UIToolbar().then {
      $0.barStyle = .default
      $0.isTranslucent = true
      $0.tintColor = .main
      $0.setItems([flexibleSpace, doneButton], animated: false)
      $0.isUserInteractionEnabled = true
      $0.sizeToFit()
    }
    return toolBar
  }
}
