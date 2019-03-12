//
//  AchievementCell.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

/// The achievement table view cell.
final class AchievementCell: UITableViewCell {
  
  /// The stage label.
  @IBOutlet weak var stageLabel: UILabel!
  
  /// The item label.
  @IBOutlet weak var itemLabel: UILabel!
  
  /// The type label.
  @IBOutlet weak var typeLabel: UILabel!
  
  /// Configures the cell with `achievementInfo`.
  ///
  /// - Parameters:
  ///   - achievementInfo: The achievement information.
  ///   - isAll:           The boolean value indicating whether the given type is all.
  func configure(with achievementInfo: AchievementInfo?, isAll: Bool = false) {
    stageLabel.text = "\(achievementInfo?.level ?? 0)"
    itemLabel.text = achievementInfo?.localizedItem
    typeLabel.text = isAll ? achievementInfo?.type.uppercased() : nil
  }
}
