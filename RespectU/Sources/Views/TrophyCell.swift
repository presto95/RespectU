//
//  TrophyCell.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

/// The trophy table view cell.
final class TrophyCell: UITableViewCell {
  
  /// The trophy thumbnail image view.
  @IBOutlet private weak var trophyThumbnailImageView: UIImageView!
  
  /// The trophy grade image view.
  @IBOutlet private weak var trophyGradeImageView: UIImageView!
  
  /// The title label.
  @IBOutlet private weak var titleLabel: UILabel!
  
  /// The content label.
  @IBOutlet private weak var contentLabel: UILabel!
  
  // MARK: Method
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
  }
  
  /// Configures initial settings.
  private func setup() {
    trophyThumbnailImageView.layer.cornerRadius = trophyThumbnailImageView.bounds.height / 2
    trophyThumbnailImageView.layer.masksToBounds = true
  }
  
  /// Configures cell with `trophyInfo`.
  ///
  /// - Parameter trophyInfo: The trophy information.
  func configure(with trophyInfo: TrophyInfo?) {
    guard let trophyInfo = trophyInfo else { return }
    if let filePath = FileManager.default
      .urls(for: .documentDirectory,
            in: .userDomainMask).first?.appendingPathComponent("\(trophyInfo.image).png").path {
      if FileManager.default.fileExists(atPath: filePath) {
        trophyThumbnailImageView.image = UIImage(contentsOfFile: filePath)
      }
    }
    titleLabel.text = trophyInfo.localizedTitle
    contentLabel.text = trophyInfo.localizedContent
    trophyGradeImageView.image = trophyInfo.ratingEnum?.image
  }
}
