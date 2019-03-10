//
//  GuideFirstCell.swift
//  RespectU
//
//  Created by Presto on 11/10/2018.
//  Copyright © 2018 Presto. All rights reserved.
//

import UIKit

/// The `protocol` that defines delegate methods of the `GuideFirstCell`.
protocol GuideFirstCellDelegate: class {
  
  /// Tells the delegate that the song stack view is tapped.
  func guideFirstCell(_ cell: GuideFirstCell, didTapSongStackView stackView: UIStackView)
  
  /// Tells the delegate that the mission stack view is tapped.
  func guideFirstCell(_ cell: GuideFirstCell, didTapMissionStackView stackView: UIStackView)
  
  /// Tells the delegate that the trophy stack view is tapped.
  func guideFirstCell(_ cell: GuideFirstCell, didTapTrophyStackView stackView: UIStackView)
  
  /// Tells the delegate that the achievement stack view is tapped.
  func guideFirstCell(_ cell: GuideFirstCell, didTapAchievementStackView stackView: UIStackView)
  
  /// Tells the delegate that the tip stack view is tapped.
  func guideFirstCell(_ cell: GuideFirstCell, didTapTipStackView stackView: UIStackView)
  
  /// Tells the delegate that the manual stack view is tapped.
  func guideFirstCell(_ cell: GuideFirstCell, didTapManualStackView stackView: UIStackView)
}

/// The guide first table view cell.
final class GuideFirstCell: UITableViewCell {
  
  // MARK: Constant
  
  /// The `enum` that defines constants.
  private enum Constant {
    
    /// The titles of the stack views.
    static let titles = ["Music", "Mission", "Trophy", "Achievement", "TIP", "Manual"]
    
    /// The image names of the stack views.
    static let imageNames = ["song", "mission", "trophy", "achievement", "tip", "manual"]
  }
  
  /// The object that acts as the delegate of the guide first cell.
  weak var delegate: GuideFirstCellDelegate?
  
  /// The background view.
  @IBOutlet private weak var view: UIView!
  
  /// The title label.
  @IBOutlet private weak var titleLabel: UILabel!
  
  /// The stack view related to song.
  @IBOutlet private weak var songStackView: UIStackView!
  
  /// The stack view related to mission.
  @IBOutlet private weak var missionStackView: UIStackView!
  
  /// The stack view related to trophy.
  @IBOutlet private weak var trophyStackView: UIStackView!
  
  /// The stack view related to achievement.
  @IBOutlet private weak var achievementStackView: UIStackView!
  
  /// The stack view related to tip.
  @IBOutlet private weak var tipStackView: UIStackView!
  
  /// The stack view related to manual.
  @IBOutlet private weak var manualStackView: UIStackView!
  
  // MARK: Life Cycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configure()
  }
  
  // MARK: Method
  
  /// Configures initial settings.
  private func configure() {
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
    stackViews.indices.forEach { index in
      let stackView = stackViews[index]
      stackView?
        .addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                     action: #selector(stackViewsDidTap(_:))))
      guard let imageView = stackView?.arrangedSubviews.first as? UIImageView else { return }
      guard let label = stackView?.arrangedSubviews.last as? UILabel else { return }
      imageView.image = UIImage(named: Constant.imageNames[index])
      label.text = Constant.titles[index].localized
    }
    titleLabel.text = L10n.guideForDJMAXRESPECT
  }
  
  /// Tells the `recognizer` that the stack views are tapped.
  @objc private func stackViewsDidTap(_ recognizer: UITapGestureRecognizer) {
    guard let stackView = recognizer.view as? UIStackView else { return }
    switch stackView.tag {
    case 0:
      delegate?.guideFirstCell(self, didTapSongStackView: stackView)
    case 1:
      delegate?.guideFirstCell(self, didTapMissionStackView: stackView)
    case 2:
      delegate?.guideFirstCell(self, didTapTrophyStackView: stackView)
    case 3:
      delegate?.guideFirstCell(self, didTapAchievementStackView: stackView)
    case 4:
      delegate?.guideFirstCell(self, didTapTipStackView: stackView)
    case 5:
      delegate?.guideFirstCell(self, didTapManualStackView: stackView)
    default:
      break
    }
  }
}
