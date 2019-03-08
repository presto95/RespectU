//
//  AchievementCell.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

final class AchievementCell: UITableViewCell {
  
  @IBOutlet weak var stageLabel: UILabel!
  
  @IBOutlet weak var itemLabel: UILabel!
  
  @IBOutlet weak var typeLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func configure(_ object: AchievementInfo?, isAll: Bool = false) {
    stageLabel.text = "\(object?.level ?? 0)"
    itemLabel.text = object?.localizedItem
    typeLabel.text = isAll ? object?.type.uppercased() : nil
  }
}
