//
//  SearchByLevelView.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 24..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

/// The search by level view.
final class SearchByLevelView: UIView {
  
  /// The picker view.
  @IBOutlet private weak var pickerView: UIPickerView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configure()
  }
  
  /// Configures initial settings.
  private func configure() {
    pickerView.selectRow(0, inComponent: 0, animated: true)
    pickerView.layer.borderWidth = 1
    pickerView.layer.borderColor = UIColor.main.cgColor
    pickerView.layer.cornerRadius = 15
  }
}
