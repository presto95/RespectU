//
//  SkillDetailView.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 5..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import GaugeKit

/// The skill level detail view.
final class SkillLevelDetailView: UIView {
  
  // MARK: Property
  
  /// The button label.
  @IBOutlet private weak var buttonLabel: UILabel!
  
  /// The gauge view.
  @IBOutlet private var gauge: Gauge!
  
  /// The skill level label.
  @IBOutlet private weak var skillLevelLabel: UILabel!
  
  /// The skill point label.
  @IBOutlet private weak var skillPointLabel: UILabel!
  
  /// The percent label.
  @IBOutlet private weak var percentLabel: UILabel!
  
  /// The record rating label.
  @IBOutlet private weak var recordRatingLabel: UILabel!
  
  // MARK: Method
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
  }
  
  private func setup() {
    layer.borderColor = UIColor.lightGray.cgColor
    layer.borderWidth = 1
    layer.cornerRadius = 15
  }
  
  func configure(with button: Button) {
    let recordRate = Utils.recordRate(in: button)
    let maxSkillPoint = Utils.maxSkillPoint(in: button)
    let mySkillPoint = Utils.totalSkillPointAndHighestSeries(in: button)
    let sum = mySkillPoint.0
    let skillLevel: String?
    switch button {
    case Button.button4:
      skillLevel = Utils.button4SkillLevel(of: sum)?.rawValue
    case Button.button5:
      skillLevel = Utils.button5SkillLevel(of: sum)?.rawValue
    case Button.button6, Button.button8:
      skillLevel = Utils.button6And8SkillLevel(of: sum)?.rawValue
    default:
      skillLevel = nil
    }
    buttonLabel.text = button.rawValue.uppercased()
    skillLevelLabel.text = skillLevel
    skillPointLabel.text = "\((sum * 100).rounded() / 100) " + L10n.point
    gauge.maxValue = CGFloat(maxSkillPoint)
    gauge.startColor = mySkillPoint.1?.color ?? .clear
    gauge.bgColor = self.gauge.startColor
    percentLabel.text = String(format: "%05.2f%%", sum * 100 / maxSkillPoint)
    recordRatingLabel.text = String(format: "%04.1f%%", recordRate * 100) + L10n.recorded
    gauge.animateRate(1, newValue: CGFloat(sum)) { _ in }
  }
}
