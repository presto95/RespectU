//
//  RankingCell.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

/// The ranking table view cell.
final class RankingCell: UITableViewCell {
  
  /// The `enum` that defines various formats.
  private enum Format {
    
    /// The format for representing the skill point.
    static let skillPoint = "%4.2f"
  }
  
  /// The ranking label.
  @IBOutlet private weak var rankingLabel: UILabel!
  
  /// The nickname label.
  @IBOutlet private weak var nicknameLabel: UILabel!
  
  /// The skill point label.
  @IBOutlet private weak var skillPointLabel: UILabel!
  
  /// Configures the cell with `response` at `row` in specific `button`.
  ///
  /// - Parameters:
  ///   - response: The ranking response object.
  ///   - row:      The specific row in table view.
  ///   - button:   The specific button.
  func configure(with response: [RankingResponse.Ranking], at row: Int, button: Button) {
    rankingLabel.text = "\(row + 1)"
    nicknameLabel.text = response[row].nickname
    switch button {
    case .button4:
      skillPointLabel.text = String(format: Format.skillPoint, response[row].button4)
    case .button5:
      skillPointLabel.text = String(format: Format.skillPoint, response[row].button5)
    case .button6:
      skillPointLabel.text = String(format: Format.skillPoint, response[row].button6)
    case .button8:
      skillPointLabel.text = String(format: Format.skillPoint, response[row].button8)
    default:
      break
    }
  }
}
