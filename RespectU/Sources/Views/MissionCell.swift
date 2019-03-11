//
//  MissionCell.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

/// The mission table view cell.
final class MissionCell: UITableViewCell {
  
  /// The color label representing the series.
  @IBOutlet private weak var colorLabel: UILabel!
  
  /// The title label.
  @IBOutlet private weak var titleLabel: UILabel!
  
  /// The reward label.
  @IBOutlet private weak var rewardLabel: UILabel!
  
  lazy var allLabel: [UILabel] = {
    return [titleLabel, rewardLabel]
  }()
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
  }
  
  /// Configures initial settings.
  private func setup() {
    colorLabel.layer.cornerRadius = colorLabel.bounds.width / 2
    colorLabel.layer.masksToBounds = true
  }
  
  /// Configures the cell with `missionInfo`.
  ///
  /// - Parameter missionInfo: The mission information.
  func configure(with missionInfo: MissionInfo?) {
    guard let missionInfo = missionInfo else { return }
    let gradient = missionInfo.section.missionGradient(.vertical) ?? CAGradientLayer()
    gradient.frame = colorLabel.bounds
    colorLabel.layer.addSublayer(gradient)
    titleLabel.text = missionInfo.title
    rewardLabel.text = missionInfo.localizedReward
  }
}
