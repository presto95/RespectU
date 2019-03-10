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
  
  func didTouchUpTop50Button(_ sender: UIButton)
  
  func didTouchUpMoreButton(_ sender: UIButton)
}

final class SkillLevelCell: UITableViewCell {
  
  weak var delegate: SkillLevelCellDelegate?
  
  @IBOutlet weak var view: UIView!
  
  @IBOutlet var gauge: Gauge!
  
  @IBOutlet weak var titleLabel: UILabel!
  
  @IBOutlet weak var skillLevelLabel: UILabel!
  
  @IBOutlet weak var skillPointLabel: UILabel!
  
  @IBOutlet weak var top50Button: UIButton!
  
  @IBOutlet weak var moreButton: UIButton!
  
  @IBOutlet weak var percentLabel: UILabel!
  
  @IBOutlet weak var nextLevelLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    titleLabel.text = "My Record".localized
    view.layer.cornerRadius = 15
    view.layer.borderWidth = 1
    view.layer.borderColor = UIColor.lightGray.cgColor
    view.layer.masksToBounds = true
    moreButton.setTitle("More".localized, for: [])
    top50Button.addTarget(self, action: #selector(didTouchUpTop50Button(_:)), for: .touchUpInside)
    moreButton.addTarget(self, action: #selector(didTouchUpMoreButton(_:)), for: .touchUpInside)
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
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
  
  @objc func didTouchUpTop50Button(_ sender: UIButton) {
    delegate?.didTouchUpTop50Button(sender)
  }
  
  @objc func didTouchUpMoreButton(_ sender: UIButton) {
    delegate?.didTouchUpMoreButton(sender)
  }
}
