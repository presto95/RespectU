//
//  RecordCell.swift
//  RespectU
//
//  Created by Presto on 2018. 4. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

/// The record table view cell.
final class RecordCell: UITableViewCell, CellColorizable {
  
  /// The color label representing the series.
  @IBOutlet private weak var colorLabel: UILabel!
  
  /// The title label.
  @IBOutlet private weak var titleLabel: UILabel!
  
  var labels: [UILabel] {
    return [titleLabel]
  }
  
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
}
