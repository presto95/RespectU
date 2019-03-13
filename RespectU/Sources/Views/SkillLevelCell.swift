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

/// The `protocol` that defines delegate methods of the `SkillLevelCell`.
protocol SkillLevelCellDelegate: class {
  
  /// Tells the delegate that the top50 button is tapped.
  ///
  /// - Parameters:
  ///   - cell:   The cell requesting this information.
  ///   - button: The button which is tapped.
  func skillLevelCell(_ cell: SkillLevelCell, didTapTop50Button button: UIButton)
  
  /// Tells the delegate that the more button is tapped.
  ///
  /// - Parameters:
  ///   - cell:   The cell requesting this information.
  ///   - button: The button which is tapped.
  func skillLevelCell(_ cell: SkillLevelCell, didTapMoreButton button: UIButton)
}

/// The skill level table view cell.
final class SkillLevelCell: UITableViewCell {
  
  /// The object that acts as the delegate of the `SkillLevelCell`.
  weak var delegate: SkillLevelCellDelegate?
  
  /// The background view.
  @IBOutlet private weak var view: UIView!
  
  /// The gauge view.
  @IBOutlet private var gauge: Gauge!
  
  /// The title label.
  @IBOutlet private weak var titleLabel: UILabel!
  
  /// The skill level label.
  @IBOutlet private weak var skillLevelLabel: UILabel!
  
  /// The skill point label.
  @IBOutlet private weak var skillPointLabel: UILabel!
  
  /// The percent label.
  @IBOutlet private weak var percentLabel: UILabel!
  
  /// The next level label.
  @IBOutlet private weak var nextLevelLabel: UILabel!
  
  /// The top50 button.
  @IBOutlet private weak var top50Button: UIButton!
  
  /// The more button.
  @IBOutlet private weak var moreButton: UIButton!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
  }

  /// Configures initial settings.
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
  
  /// Configures the cell in `button` with `max` and `record`.
  ///
  /// - Parameters:
  ///   - button:   The specific button.
  ///   - max:      The maximum skill point.
  ///   - record:   The tuple with the total skill point
  ///               and the highest series of the total skill point.
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
    let nextLevel = Utils.nextSkillLevel(of: skillLevelEnum, in: button) ?? .beginner
    nextLevelLabel.text = skillLevelEnum == .theDjmax
      ? nil
      : "\(L10n.next) : \(nextLevel.rawValue)"
    percentLabel.text = String(format: "%05.2f%%", totalSkillPoint * 100 / max)
  }
  
  /// Tells the `sender` that the top50 button is tapped.
  @objc private func top50ButtonDidTap(_ sender: UIButton) {
    delegate?.skillLevelCell(self, didTapTop50Button: sender)
  }
  
  /// Tells the `sender` that the more button is tapped.
  @objc private func moreButtonDidTap(_ sender: UIButton) {
    delegate?.skillLevelCell(self, didTapMoreButton: sender)
  }
}
