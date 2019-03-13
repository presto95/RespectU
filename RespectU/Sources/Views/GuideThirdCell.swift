//
//  GuideThirdCell.swift
//  RespectU
//
//  Created by Presto on 11/10/2018.
//  Copyright © 2018 Presto. All rights reserved.
//

import UIKit

/// The `protocol` that defines delegate methods of the `GuideThirdCell`.
protocol GuideThirdCellDelegate: class {
  
  /// Tells the delegate that the download stack view is tapped.
  ///
  /// - Parameters:
  ///   - cell:       The cell requesting this information.
  ///   - stackView:  The stack view which is tapped.
  func guideThirdCell(_ cell: GuideThirdCell, didTapDownloadStackView stackView: UIStackView)
  
  /// Tells the delegate that the upload stack view is tapped.
  ///
  /// - Parameters:
  ///   - cell:       The cell requesting this information.
  ///   - stackView:  The stack view which is tapped.
  func guideThirdCell(_ cell: GuideThirdCell, didTapUploadStackView stackView: UIStackView)
  
  /// Tells the delegate that the email stack view is tapped.
  ///
  /// - Parameters:
  ///   - cell:       The cell requesting this information.
  ///   - stackView:  The stack view which is tapped.
  func guideThirdCell(_ cell: GuideThirdCell, didTapEmailStackView stackView: UIStackView)
  
  /// Tells the delegate that the radio stack view is tapped.
  ///
  /// - Parameters:
  ///   - cell:       The cell requesting this information.
  ///   - stackView:  The stack view which is tapped.
  func guideThirdCell(_ cell: GuideThirdCell, didTapRadioStackView stackView: UIStackView)
  
  /// Tells the delegate that the credit stack view is tapped.
  ///
  /// - Parameters:
  ///   - cell:       The cell requesting this information.
  ///   - stackView:  The stack view which is tapped.
  func guideThirdCell(_ cell: GuideThirdCell, didTapCreditStackView stackView: UIStackView)
  
  /// Tells the delegate that the rate stack view is tapped.
  ///
  /// - Parameters:
  ///   - cell:       The cell requesting this information.
  ///   - stackView:  The stack view which is tapped.
  func guideThirdCell(_ cell: GuideThirdCell, didTapRateStackView stackView: UIStackView)
}

/// The guide third cell table view cell.
final class GuideThirdCell: UITableViewCell {
  
  // MARK: Constant
  
  /// The `enum` that defines constants.
  private enum Constant {
    
    /// The titles of the stack views.
    static let titles = [
      "Download From Server",
      "Upload To Server",
      "Send Email to Developer",
      "DJMAX Radio Station",
      "Credit",
      "Rate This App"
    ]
    
    /// The image names of the stack views.
    static let imageNames = ["download", "upload", "email", "radio", "credit", "rate"]
  }
  
  /// The object that acts as the delegate of the guide third cell.
  weak var delegate: GuideThirdCellDelegate?
  
  /// The background view.
  @IBOutlet private weak var view: UIView!
  
  /// The title label.
  @IBOutlet private weak var titleLabel: UILabel!
  
  /// The stack view related to download.
  @IBOutlet private weak var downloadStackView: UIStackView!
  
  /// The stack view related to upload.
  @IBOutlet private weak var uploadStackView: UIStackView!
  
  /// The stack view related to email.
  @IBOutlet private weak var emailStackView: UIStackView!
  
  /// The stack view related to radio.
  @IBOutlet private weak var radioStackView: UIStackView!
  
  /// The stack view related to credit.
  @IBOutlet private weak var creditStackView: UIStackView!
  
  /// The stack view related to rating.
  @IBOutlet private weak var ratingStackView: UIStackView!
  
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
      downloadStackView,
      uploadStackView,
      emailStackView,
      radioStackView,
      creditStackView,
      ratingStackView
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
    titleLabel.text = L10n.more
  }
  
  /// Tells the `recognizer` that the stack views are tapped.
  @objc private func stackViewsDidTap(_ recognizer: UITapGestureRecognizer) {
    guard let stackView = recognizer.view as? UIStackView else { return }
    switch stackView.tag {
    case 0:
      delegate?.guideThirdCell(self, didTapDownloadStackView: stackView)
    case 1:
      delegate?.guideThirdCell(self, didTapUploadStackView: stackView)
    case 2:
      delegate?.guideThirdCell(self, didTapEmailStackView: stackView)
    case 3:
      delegate?.guideThirdCell(self, didTapRadioStackView: stackView)
    case 4:
      delegate?.guideThirdCell(self, didTapCreditStackView: stackView)
    case 5:
      delegate?.guideThirdCell(self, didTapRateStackView: stackView)
    default:
      break
    }
  }
}
