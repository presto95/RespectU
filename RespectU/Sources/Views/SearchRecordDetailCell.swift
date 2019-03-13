//
//  SearchRecordDetailCell.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 19..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import RealmSwift

/// The search record detail table view cell.
final class SearchRecordDetailCell: UITableViewCell {
  
  /// The color label representing the series.
  @IBOutlet private weak var colorLabel: UILabel!
  
  /// The title label.
  @IBOutlet private weak var titleLabel: UILabel!
  
  /// The difficulty label.
  @IBOutlet private weak var difficultyLabel: UILabel!
  
  /// The rating label.
  @IBOutlet private weak var ratingLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
  }
  
  /// Configures initial settings.
  private func setup() {
    colorLabel.layer.cornerRadius = colorLabel.bounds.width / 2
    colorLabel.layer.masksToBounds = true
  }
  
  /// Configures the cell with `searchRecordDetail`.
  func configure(with searchRecordDetail: SearchRecordDetail) {
    let series = Series(rawValue: searchRecordDetail.series) ?? .respect
    let gradient = (series.makeGradient(by: .vertical) ?? CAGradientLayer()).then {
      $0.frame = colorLabel.bounds
    }
    colorLabel.layer.addSublayer(gradient)
    titleLabel.text = searchRecordDetail.title
    difficultyLabel.text = searchRecordDetail.difficulty.uppercased()
    ratingLabel.text = "\(searchRecordDetail.rate)%"
  }
}
