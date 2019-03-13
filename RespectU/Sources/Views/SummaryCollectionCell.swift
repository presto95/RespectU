//
//  SummaryCollectionCell.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 5..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import RealmSwift

/// The summary collection cell.
final class SummaryCollectionCell: UICollectionViewCell {
  
  /// The content label.
  @IBOutlet private weak var contentLabel: UILabel!
  
  /// The value label.
  @IBOutlet private weak var valueLabel: UILabel!
  
  /// The content titles.
  private let contentTitles = [
    Rank.s.rawValue.uppercased(),
    Rank.a.rawValue.uppercased(),
    Rank.b.rawValue.uppercased(),
    Rank.c.rawValue.uppercased(),
    Note.maxCombo.rawValue,
    Note.perfectPlay.rawValue,
    "\(Note.maxCombo.rawValue)+\(Note.perfectPlay.rawValue)"
  ]
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
  }
  
  /// Configures initial settings.
  private func setup() {
    layer.borderColor = UIColor.main.cgColor
    layer.borderWidth = 1
    layer.cornerRadius = 15
  }
  
  /// Configures the `item`th cell with `records`.
  ///
  /// - Parameters:
  ///   - records:  The results of record.
  ///   - item:     The index of the cell.
  func configure(with records: Results<RecordInfo>, at item: Int) {
    let buttons = Button.all.map { $0.expansion }.compactMap { $0 }
    let difficulties = Difficulty.all.map { $0.rawValue }.compactMap { $0 }
    var count: Int = 0
    contentLabel.text = contentTitles[item]
    switch item {
    case 0, 1, 2, 3:
      valueLabel.text = {
        for result in records {
          for button in buttons {
            guard let buttonResult = result.value(forKey: button) as? RecordButtonInfo
              else { return nil }
            for difficulty in difficulties {
              guard let difficultyResult
                = buttonResult.value(forKey: difficulty) as? RecordDifficultyInfo
                else { return nil }
              if difficultyResult.rank == contentTitles[item] {
                count += 1
              }
            }
          }
        }
        return "\(count)"
      }()
    case 4, 5:
      valueLabel.text = {
        for result in records {
          for button in buttons {
            guard let buttonResult = result.value(forKey: button) as? RecordButtonInfo
              else { return nil }
            for difficulty in difficulties {
              guard let difficultyResult
                = buttonResult.value(forKey: difficulty) as? RecordDifficultyInfo
                else { return nil }
              if difficultyResult.note == contentTitles[item] {
                count += 1
              }
            }
          }
        }
        return "\(count)"
      }()
    case 6:
      valueLabel.text = {
        for result in records {
          for button in buttons {
            guard let buttonResult = result.value(forKey: button) as? RecordButtonInfo
              else { return nil }
            for difficulty in difficulties {
              guard let difficultyResult
                = buttonResult.value(forKey: difficulty) as? RecordDifficultyInfo
                else { return nil }
              if difficultyResult.note == contentTitles[4]
                || difficultyResult.note == contentTitles[5] {
                count += 1
              }
            }
          }
        }
        return "\(count)"
      }()
    default:
      break
    }
  }
}
