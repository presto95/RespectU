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
  
  func setProperties(_ button: Button, max: Double, myRecord: (sum: Double, highestSeries: String)) {
    let mySkillPointSum = myRecord.sum
    let myHighestSeries = myRecord.highestSeries
    let seriesColor = myHighestSeries.seriesColor ?? .clear
    gauge.maxValue = CGFloat(max)
    gauge.rate = CGFloat(mySkillPointSum)
    gauge.startColor = seriesColor
    gauge.bgColor = seriesColor
    skillPointLabel.text = "\((mySkillPointSum * 100).rounded() / 100) " + "Point".localized
    skillLevelLabel.text = {
      switch button {
      case Button.button4:
        return Skill.button4SkillLevel(mySkillPointSum)
      case Button.button5:
        return Skill.button5SkillLevel(mySkillPointSum)
      case Button.button6, Button.button8:
        return Skill.button6And8SkillLevel(mySkillPointSum)
      default:
        return nil
      }
    }()
    nextLevelLabel.text = Skill.nextSkillLevel(of: self.skillLevelLabel.text ?? "", button: button)
    percentLabel.text = String(format: "%05.2f%%", mySkillPointSum * 100 / max)
  }
  
  @objc func top50ButtonDidTap(_ sender: UIButton) {
    delegate?.skillLevelCell(self, didTapTop50Button: sender)
  }
  
  @objc func moreButtonDidTap(_ sender: UIButton) {
    delegate?.skillLevelCell(self, didTapMoreButton: sender)
  }
}
