//
//  GuideThirdCell.swift
//  RespectU
//
//  Created by Presto on 11/10/2018.
//  Copyright © 2018 Presto. All rights reserved.
//

import UIKit

protocol GuideThirdCellDelegate: class {
  func didTapDownloadStackView()
  func didTapUploadStackView()
  func didTapEmailStackView()
  func didTapRadioStackView()
  func didTapCreditStackView()
  func didTapRateStackView()
}

final class GuideThirdCell: UITableViewCell {
  
  let titles = [
    "Download From Server",
    "Upload To Server",
    "Send Email to Developer",
    "DJMAX Radio Station",
    "Credit",
    "Rate This App"
  ]
  
  let imageNames = ["download", "upload", "email", "radio", "credit", "rate"]
  
  weak var delegate: GuideThirdCellDelegate?
  
  @IBOutlet weak var view: UIView!
  
  @IBOutlet weak var titleLabel: UILabel!
  
  @IBOutlet weak var downloadStackView: UIStackView!
  
  @IBOutlet weak var uploadStackView: UIStackView!
  
  @IBOutlet weak var emailStackView: UIStackView!
  
  @IBOutlet weak var radioStackView: UIStackView!
  
  @IBOutlet weak var creditStackView: UIStackView!
  
  @IBOutlet weak var rateStackView: UIStackView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    view.layer.cornerRadius = 15
    view.layer.borderWidth = 1
    view.layer.borderColor = UIColor.lightGray.cgColor
    view.layer.masksToBounds = true
    let stackViews = [
      downloadStackView,
      uploadStackView,
      emailStackView,
      radioStackView,
      creditStackView,
      rateStackView
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
    titleLabel.text = "More".localized
  }
  
  @objc func stackViewsDidTap(_ recognizer: UITapGestureRecognizer) {
    guard let stackView = recognizer.view else { return }
    switch stackView.tag {
    case 0:
      delegate?.didTapDownloadStackView()
    case 1:
      delegate?.didTapUploadStackView()
    case 2:
      delegate?.didTapEmailStackView()
    case 3:
      delegate?.didTapRadioStackView()
    case 4:
      delegate?.didTapCreditStackView()
    case 5:
      delegate?.didTapRateStackView()
    default:
      break
    }
  }
}
