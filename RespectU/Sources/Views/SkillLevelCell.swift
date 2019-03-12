//
//  SkillPointCell.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import GaugeKit
import RealmSwift

protocol SkillLevelCellDelegate: class {
  
  func skillLevelCell(_ cell: SkillLevelCell, didTapTop50Button button: UIButton)
  
  func skillLevelCell(_ cell: SkillLevelCell, didTapMoreButton button: UIButton)
}

final class SkillLevelCell: UITableViewCell {
  
  weak var delegate: SkillLevelCellDelegate?
  
  @IBOutlet private weak var view: UIView!
  
  @IBOutlet private var gauge: Gauge!
  
  @IBOutlet private weak var titleLabel: UILabel!
  
  @IBOutlet private weak var skillLevelLabel: UILabel!
  
  @IBOutlet private weak var skillPointLabel: UILabel!
  
  @IBOutlet private weak var top50Button: UIButton!
  
  @IBOutlet private weak var moreButton: UIButton!
  
  @IBOutlet private weak var percentLabel: UILabel!
  
  @IBOutlet private weak var nextLevelLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
  }

  private func setup() {
    titleLabel.text = L10n.myRecord
    view.layer.cornerRadius = 15
    view.layer.borderWidth = 1
    view.layer.borderColor = UIColor.lightGray.cgColor
    view.layer.masksToBounds = true
    moreButton.setTitle(L10n.more, for: [])
    top50Button.addTarget(self, action: #selector(top50ButtonDidTap(_:)), for: .touchUpInside)
    moreButton.addTarget(self, action: #selector(moreButtonDidTap(_:)), for: .touchUpInside)
  }
  
  func configure(inButton button: Button, max: Double, record: (Double, Series?)) {
    let totalSkillPoint = record.0
    let highestSeries = record.1
    let colorOfSeries = highestSeries?.color ?? .clear
    gauge.maxValue = CGFloat(max)
    gauge.rate = CGFloat(totalSkillPoint)
    gauge.startColor = colorOfSeries
    gauge.endColor = colorOfSeries
    skillPointLabel.text = "\((totalSkillPoint * 100).rounded() / 100) \(L10n.point)"
    let skillLevel: String?
    switch button {
    case .button4:
      skillLevel = Utils.button4SkillLevel(of: totalSkillPoint)?.rawValue
    case .button5:
      skillLevel = Utils.button5SkillLevel(of: totalSkillPoint)?.rawValue
    case .button6, .button8:
      skillLevel = Utils.button6And8SkillLevel(of: totalSkillPoint)?.rawValue
    default:
      skillLevel = nil
    }
    skillLevelLabel.text = skillLevel
    let skillLevelEnum = SkillLevel(rawValue: skillLevel ?? "") ?? .beginner
    nextLevelLabel.text = Utils.nextSkillLevel(of: skillLevelEnum, in: button)?.rawValue
    percentLabel.text = String(format: "%05.2f%%", totalSkillPoint * 100 / max)
  }

  @objc private func top50ButtonDidTap(_ sender: UIButton) {
    delegate?.skillLevelCell(self, didTapTop50Button: sender)
  }
  
  @objc private func moreButtonDidTap(_ sender: UIButton) {
    delegate?.skillLevelCell(self, didTapMoreButton: sender)
  }
}
