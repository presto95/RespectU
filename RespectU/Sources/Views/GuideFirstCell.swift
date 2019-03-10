//
//  GuideFirstCell.swift
//  RespectU
//
//  Created by Presto on 11/10/2018.
//  Copyright © 2018 Presto. All rights reserved.
//

import UIKit

protocol GuideFirstCellDelegate: class {
  func didTapSongStackView()
  func didTapMissionStackView()
  func didTapTrophyStackView()
  func didTapAchievementStackView()
  func didTapTipStackView()
  func didTapManualStackView()
}

final class GuideFirstCell: UITableViewCell {
  
  let titles = ["Music", "Mission", "Trophy", "Achievement", "TIP", "Manual"]
  
  let imageNames = ["song", "mission", "trophy", "achievement", "tip", "manual"]
  
  weak var delegate: GuideFirstCellDelegate?
  
  @IBOutlet weak var view: UIView!
  
  @IBOutlet weak var titleLabel: UILabel!
  
  @IBOutlet weak var songStackView: UIStackView!
  
  @IBOutlet weak var missionStackView: UIStackView!
  
  @IBOutlet weak var trophyStackView: UIStackView!
  
  @IBOutlet weak var achievementStackView: UIStackView!
  
  @IBOutlet weak var tipStackView: UIStackView!
  
  @IBOutlet weak var manualStackView: UIStackView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    view.layer.cornerRadius = 15
    view.layer.borderWidth = 1
    view.layer.borderColor = UIColor.lightGray.cgColor
    view.layer.masksToBounds = true
    let stackViews = [
      songStackView,
      missionStackView,
      trophyStackView,
      achievementStackView,
      tipStackView,
      manualStackView
    ]
    for index in 0..<stackViews.count {
      let stackView = stackViews[index]
      stackView?
        .addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                     action: #selector(stackViewsDidTap(_:))))
      guard let imageView = stackView?.arrangedSubviews.first as? UIImageView else { return }
      guard let label = stackView?.arrangedSubviews.last as? UILabel else { return }
      imageView.image = UIImage(named: imageNames[index])
      label.text = titles[index].localized
    }
    titleLabel.text = "Guide for DJMAX RESPECT".localized
  }
  
  @objc func stackViewsDidTap(_ recognizer: UITapGestureRecognizer) {
    guard let stackView = recognizer.view else { return }
    switch stackView.tag {
    case 0:
      delegate?.didTapSongStackView()
    case 1:
      delegate?.didTapMissionStackView()
    case 2:
      delegate?.didTapTrophyStackView()
    case 3:
      delegate?.didTapAchievementStackView()
    case 4:
      delegate?.didTapTipStackView()
    case 5:
      delegate?.didTapManualStackView()
    default:
      break
    }
  }
}
