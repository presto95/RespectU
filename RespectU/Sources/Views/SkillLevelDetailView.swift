//
//  SkillDetailView.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 5..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import GaugeKit

final class SkillLevelDetailView: UIView {
  
  @IBOutlet weak var buttonLabel: UILabel!
  
  @IBOutlet var gauge: Gauge!
  
  @IBOutlet weak var skillLevelLabel: UILabel!
  
  @IBOutlet weak var skillPointLabel: UILabel!
  
  @IBOutlet weak var percentLabel: UILabel!
  
  @IBOutlet weak var recordRateLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    layer.borderColor = UIColor.lightGray.cgColor
    layer.borderWidth = 1
    layer.cornerRadius = 15
  }
  
  func setProperties(button: String) {
    let recordRate = Skill.recordRate(button: button)
    let maxSkillPoint = Skill.maxSkillPoint(button: button)
    let mySkillPoint = Skill.mySkillPointAndHighestSeries(button: button)
    let sum = mySkillPoint.sum
    let skillLevel: String?
    switch button {
    case Buttons.button4:
      skillLevel = Skill.button4SkillLevel(sum)
    case Buttons.button5:
      skillLevel = Skill.button5SkillLevel(sum)
    case Buttons.button6, Buttons.button8:
      skillLevel = Skill.button6And8SkillLevel(sum)
    default:
      skillLevel = nil
    }
    buttonLabel.text = button.uppercased()
    skillLevelLabel.text = skillLevel
    skillPointLabel.text = "\((sum * 100).rounded() / 100) " + "Point".localized
    gauge.maxValue = CGFloat(maxSkillPoint)
    gauge.startColor = mySkillPoint.highestSeries.seriesColor ?? .clear
    gauge.bgColor = self.gauge.startColor
    percentLabel.text = String(format: "%05.2f%%", sum * 100 / maxSkillPoint)
    recordRateLabel.text = String(format: "%04.1f%%", recordRate * 100) + " Recorded".localized
    gauge.animateRate(1, newValue: CGFloat(sum)) { _ in }
  }
}
