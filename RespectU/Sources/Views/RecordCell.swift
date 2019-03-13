//
//  RecordCell.swift
//  RespectU
//
//  Created by Presto on 2018. 4. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

/// The record table view cell.
final class RecordCell: UITableViewCell {
  
  /// The color label representing the series.
  @IBOutlet private weak var colorLabel: UILabel!
  
  /// The title label.
  @IBOutlet private weak var titleLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
  }
  
  /// Configures initial settings.
  private func setup() {
    colorLabel.layer.cornerRadius = colorLabel.bounds.width / 2
    colorLabel.layer.masksToBounds = true
  }
  
  /// Configures the cell with `songInfo`.
  ///
  /// - Parameter songInfo: The song information.
  func configure(with songInfo: SongInfo?) {
    guard let songInfo = songInfo else { return }
    let gradient = songInfo.seriesEnum?.makeGradient(by: .vertical) ?? CAGradientLayer()
    gradient.frame = colorLabel.bounds
    colorLabel.layer.addSublayer(gradient)
    titleLabel.text = songInfo.localizedTitle
  }
  
  /// Colorizes subviews in `series`.
  ///
  /// - Parameter series: The specific series.
  func colorizeSubviews(in series: Series) {
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }
      switch series {
      case .portable1:
        self.contentView.backgroundColor = .portable1
        self.titleLabel.textColor = .white
      case .portable2:
        self.contentView.backgroundColor = .portable2
        self.titleLabel.textColor = .white
      case .respect:
        self.contentView.backgroundColor = .respect
        self.titleLabel.textColor = .white
      case .trilogy:
        self.contentView.backgroundColor = .trilogy
        self.titleLabel.textColor = .white
      case .ce:
        self.contentView.backgroundColor = .ce
        self.titleLabel.textColor = .black50
      case .technika1:
        self.contentView.backgroundColor = .technika1
        self.titleLabel.textColor = .white
      case .bs:
        self.contentView.backgroundColor = .bs
        self.titleLabel.textColor = .white
      case .technika2:
        self.contentView.backgroundColor = .technika2
        self.titleLabel.textColor = .black50
      case .technika3:
        break
      default:
        break
      }    }
  }
  
  /// Decolorizes subviews.
  ///
  /// Reset all the colors of subviews.
  func decolorizeSubviews() {
    DispatchQueue.main.async { [weak self] in
      self?.contentView.backgroundColor = .white
      self?.titleLabel.textColor = .black50
    }
  }
}
