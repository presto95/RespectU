//
//  GuideSecondCell.swift
//  RespectU
//
//  Created by Presto on 11/10/2018.
//  Copyright © 2018 Presto. All rights reserved.
//

import UIKit

protocol GuideSecondCellDelegate: class {
  func didTapUpLogInOutStackView()
  func didTapBPMSettingStackView()
  func didTapFavoriteButtonStackView()
}

final class GuideSecondCell: UITableViewCell {
  
  let titles = ["Login / Logout", "BPM Default Setting", "My Favorite Button"]
  
  let imageNames = ["log", "bpmDefault", "favorite"]
  
  weak var delegate: GuideSecondCellDelegate?
  
  @IBOutlet weak var view: UIView!
  
  @IBOutlet weak var titleLabel: UILabel!
  
  @IBOutlet weak var logInOutStackView: UIStackView!
  
  @IBOutlet weak var bpmSettingStackView: UIStackView!
  
  @IBOutlet weak var favoriteButtonStackView: UIStackView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    view.layer.cornerRadius = 15
    view.layer.borderWidth = 1
    view.layer.borderColor = UIColor.lightGray.cgColor
    view.layer.masksToBounds = true
    let stackViews = [logInOutStackView, bpmSettingStackView, favoriteButtonStackView]
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
    titleLabel.text = "Personal Setting".localized
  }
  
  @objc func stackViewsDidTap(_ recognizer: UITapGestureRecognizer) {
    guard let stackView = recognizer.view else { return }
    switch stackView.tag {
    case 0:
      delegate?.didTapUpLogInOutStackView()
    case 1:
      delegate?.didTapBPMSettingStackView()
    case 2:
      delegate?.didTapFavoriteButtonStackView()
    default:
      break
    }
  }
}
