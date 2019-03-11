//
//  SongCell.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 3..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import RealmSwift

/// The song table view cell.
final class SongCell: UITableViewCell {
  
  /// The color label representing the series.
  @IBOutlet private weak var colorLabel: UILabel!
  
  /// The title label.
  @IBOutlet private weak var titleLabel: UILabel!
  
  /// The composer label.
  @IBOutlet private weak var composerLabel: UILabel!
  
  /// The bpm label.
  @IBOutlet private weak var bpmLabel: UILabel!
  
  /// The normal difficulty label.
  @IBOutlet private weak var normalLabel: UILabel!
  
  /// The hard difficulty label.
  @IBOutlet private weak var hardLabel: UILabel!
  
  /// The maximum difficulty label.
  @IBOutlet private weak var maximumLabel: UILabel!
  
  private var allLabel: [UILabel] {
    return [
      titleLabel,
      composerLabel,
      bpmLabel,
      normalLabel,
      hardLabel,
      maximumLabel
    ]
  }
  
  // MARK: Method
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
  }
  
  /// Configures initial settings.
  private func setup() {
    colorLabel.layer.cornerRadius = colorLabel.bounds.width / 2
    colorLabel.layer.masksToBounds = true
  }
  
  /// Configures cell with `songInfo` in specific `button`.
  ///
  /// - Parameters:
  ///   - songInfo: The song information.
  ///   - button:   The specific button.
  func configure(with songInfo: SongInfo?, favoriteButton button: Button) {
    guard let songInfo = songInfo else { return }
    let gradient = songInfo.seriesEnum?.makeGradient(by: .vertical) ?? CAGradientLayer()
    gradient.frame = colorLabel.bounds
    colorLabel.layer.addSublayer(gradient)
    titleLabel.text = songInfo.localizedTitle
    composerLabel.text = songInfo.composer
    bpmLabel.text = songInfo.bpmToString
    let buttonInfo: SongButtonInfo?
    switch button {
    case .button4:
      buttonInfo = songInfo.button4
    case .button5:
      buttonInfo = songInfo.button5
    case .button6:
      buttonInfo = songInfo.button6
    case .button8:
      buttonInfo = songInfo.button8
    default:
      break
    }
    normalLabel.text = buttonInfo?.normal == 0 ? "-" : "\(buttonInfo?.normal ?? 0)"
    hardLabel.text = buttonInfo?.hard == 0 ? "-" : "\(buttonInfo?.hard ?? 0)"
    maximumLabel.text = buttonInfo?.maximum == 0 ? "-" : "\(buttonInfo?.maximum ?? 0)"
  }
}

extension SongCell {
  
  /// Colorizes subviews.
  ///
  /// - Parameter series: The specific series.
  func colorizeSubviews(in series: Series) {
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }
      switch series {
      case .portable1:
        self.contentView.backgroundColor = .portable1
        self.allLabel.forEach { $0.textColor = .white }
      case .portable2:
        self.contentView.backgroundColor = .portable2
        self.allLabel.forEach { $0.textColor = .white }
      case .respect:
        self.contentView.backgroundColor = .respect
        self.allLabel.forEach { $0.textColor = .white }
      case .trilogy:
        self.contentView.backgroundColor = .trilogy
        self.allLabel.forEach { $0.textColor = .white }
      case .ce:
        self.contentView.backgroundColor = .ce
        self.allLabel.forEach { $0.textColor = .black50 }
      case .technika1:
        self.contentView.backgroundColor = .technika1
        self.allLabel.forEach { $0.textColor = .white }
      case .bs:
        self.contentView.backgroundColor = .bs
        self.allLabel.forEach { $0.textColor = .white }
      case .technika2:
        self.contentView.backgroundColor = .technika2
        self.allLabel.forEach { $0.textColor = .black50 }
      case .technika3:
        break
      default:
        break
      }
    }
  }
}
