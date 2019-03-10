//
//  GuideSecondCell.swift
//  RespectU
//
//  Created by Presto on 11/10/2018.
//  Copyright © 2018 Presto. All rights reserved.
//

import UIKit

/// The `protocol` that defines delegate methods of the `GuideSecondCell`.
protocol GuideSecondCellDelegate: class {
  
  /// Tells the delegate that the log in-out stack view is tapped.
  func guideSecondCell(_ cell: GuideSecondCell, didTapLogInOutStackView stackView: UIStackView)
  
  /// Tells the delegate that the bpm setting stack view is tapped.
  func guideSecondCell(_ cell: GuideSecondCell, didTapBPMSettingStackView stackView: UIStackView)
  
  /// Tells the delegate that the favorite button stack view is tapped.
  func guideSecondCell(_ cell: GuideSecondCell,
                       didTapFavoriteButtonStackView stackView: UIStackView)
}

/// The guide second cell table view cell.
final class GuideSecondCell: UITableViewCell {
  
  // MARK: Constant
  
  /// The `enum` that defines constants.
  private enum Constant {
    
    /// The titles of the stack views.
    static let titles = ["Login / Logout", "BPM Default Setting", "My Favorite Button"]
    
    /// The image names of the stack views.
    static let imageNames = ["log", "bpmDefault", "favorite"]
  }
  
  /// The object that acts as the delegate of the guide second cell.
  weak var delegate: GuideSecondCellDelegate?
  
  /// The background view.
  @IBOutlet private weak var view: UIView!
  
  /// The title label.
  @IBOutlet private weak var titleLabel: UILabel!
  
  /// The stack view related to log in-out.
  @IBOutlet private weak var logInOutStackView: UIStackView!
  
  /// The stack view related to bpm setting.
  @IBOutlet private weak var bpmSettingStackView: UIStackView!
  
  /// The stack view related to favorite button.
  @IBOutlet private weak var favoriteButtonStackView: UIStackView!
  
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
    let stackViews = [logInOutStackView, bpmSettingStackView, favoriteButtonStackView]
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
    titleLabel.text = L10n.personalSetting
  }
  
  /// Tells the `recognizer` that the stack views are tapped.
  @objc private func stackViewsDidTap(_ recognizer: UITapGestureRecognizer) {
    guard let stackView = recognizer.view as? UIStackView else { return }
    switch stackView.tag {
    case 0:
      delegate?.guideSecondCell(self, didTapLogInOutStackView: stackView)
    case 1:
      delegate?.guideSecondCell(self, didTapBPMSettingStackView: stackView)
    case 2:
      delegate?.guideSecondCell(self, didTapFavoriteButtonStackView: stackView)
    default:
      break
    }
  }
}
