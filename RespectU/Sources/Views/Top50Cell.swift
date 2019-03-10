//
//  Top50Cell.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

final class Top50Cell: UITableViewCell {
  
  @IBOutlet weak var colorLabel: UILabel!
  
  @IBOutlet weak var titleLabel: UILabel!
  
  @IBOutlet weak var difficultyLabel: UILabel!
  
  @IBOutlet weak var noteLabel: UILabel!
  
  @IBOutlet weak var rateLabel: UILabel!
  
  @IBOutlet weak var skillPointLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    colorLabel.layer.cornerRadius = colorLabel.bounds.width / 2
    colorLabel.layer.masksToBounds = true
  }
  
  func setProperties(_ object: RecordInfo, button: Button) {
    let gradient = object.series.seriesGradient(.vertical) ?? CAGradientLayer()
    gradient.frame = colorLabel.bounds
    colorLabel.layer.addSublayer(gradient)
    titleLabel.text = object.localizedTitle
    guard let buttonExpansion = button.buttonExpansion else { return }
    guard let button = object.value(forKeyPath: buttonExpansion) as? NewRecordButtonInfo else { return }
    difficultyLabel.text = button.skillPointDifficulty.isEmpty ? "-" : button.skillPointDifficulty.uppercased()
    noteLabel.text = button.skillPointNote.isEmpty ? "-" : button.skillPointNote.noteExpansion
    rateLabel.text = button.skillPointRate == 0 ? "-" : "\(button.skillPointRate)%"
    skillPointLabel.text = String(format: "%05.2f", button.skillPoint)
  }
}
