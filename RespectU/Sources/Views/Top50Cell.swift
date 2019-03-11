//
//  Top50Cell.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

/// The top50 table view cell.
final class Top50Cell: UITableViewCell {
  
  /// The color label representing the series.
  @IBOutlet private weak var colorLabel: UILabel!
  
  /// The title label.
  @IBOutlet private weak var titleLabel: UILabel!
  
  /// The difficulty label.
  @IBOutlet private weak var difficultyLabel: UILabel!
  
  /// The note label.
  @IBOutlet private weak var noteLabel: UILabel!
  
  /// The rating label.
  @IBOutlet private weak var ratingLabel: UILabel!
  
  /// The skill point label.
  @IBOutlet private weak var skillPointLabel: UILabel!
  
  // MARK: Method
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
  }
  
  /// Configures initial settings.
  private func setup() {
    colorLabel.layer.cornerRadius = colorLabel.bounds.width / 2
    colorLabel.layer.masksToBounds = true
  }
  
  /// Configures cell with `recordInfo` in specific `button`.
  ///
  /// - Parameters:
  ///   - recordInfo: The record information.
  ///   - button:     The specific button.
  func configure(with recordInfo: RecordInfo, button: Button) {
    let gradient = recordInfo.seriesEnum?.makeGradient(by: .vertical) ?? CAGradientLayer()
    gradient.frame = colorLabel.bounds
    colorLabel.layer.addSublayer(gradient)
    titleLabel.text = recordInfo.localizedTitle
    guard let buttonExpansion = button.expansion else { return }
    guard let button = recordInfo.value(forKeyPath: buttonExpansion) as? RecordButtonInfo
      else { return }
    difficultyLabel.text
      = button.skillPointDifficulty.isEmpty ? "-" : button.skillPointDifficulty.uppercased()
    noteLabel.text
      = button.skillPointNote.isEmpty ? "-" : Note(rawValue: button.skillPointNote)?.expansion
    ratingLabel.text = button.skillPointRate == 0 ? "-" : "\(button.skillPointRate)%"
    skillPointLabel.text = String(format: "%05.2f", button.skillPoint)
  }
}
