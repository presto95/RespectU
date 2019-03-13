//
//  MissionCell.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

/// The mission table view cell.
final class MissionCell: UITableViewCell {
  
  /// The color label representing the series.
  @IBOutlet private weak var colorLabel: UILabel!
  
  /// The title label.
  @IBOutlet private weak var titleLabel: UILabel!
  
  /// The reward label.
  @IBOutlet private weak var rewardLabel: UILabel!
  
  lazy var allLabel: [UILabel] = {
    return [titleLabel, rewardLabel]
  }()
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
  }
  
  /// Configures initial settings.
  private func setup() {
    colorLabel.layer.cornerRadius = colorLabel.bounds.width / 2
    colorLabel.layer.masksToBounds = true
  }
  
  /// Configures the cell with `missionInfo`.
  ///
  /// - Parameter missionInfo: The mission information.
  func configure(with missionInfo: MissionInfo?) {
    guard let missionInfo = missionInfo else { return }
    let series = missionInfo.seriesEnum ?? .respect
    let section = missionInfo.section
    let gradient = MissionSection
      .makeSection(bySeries: series, section: section)?
      .makeGradient(by: .vertical) ?? CAGradientLayer()
    gradient.frame = colorLabel.bounds
    colorLabel.layer.addSublayer(gradient)
    titleLabel.text = missionInfo.title
    rewardLabel.text = missionInfo.localizedReward
  }
  
  func colorizeSubviews(inSeries series: Series, section: String) {
    let missionSection = MissionSection.makeSection(bySeries: series, section: section)
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }
      self.contentView.backgroundColor = missionSection?.color
      self.allLabel.forEach { $0.textColor = .white }
    }
  }
  
  func decolorizeSubviews() {
    DispatchQueue.main.async { [weak self] in
      self?.contentView.backgroundColor = .white
      self?.allLabel.forEach { $0.textColor = .black50 }
    }
  }
}
