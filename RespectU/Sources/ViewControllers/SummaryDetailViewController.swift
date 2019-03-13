//
//  SummaryDetailViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 5..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

import RealmSwift

/// The summary detail view controller.
final class SummaryDetailViewController: UIViewController {
  
  /*
   The data about each index
   0 / 1 / 2 / 3 / 4 / 5 / 6 / 7 : Accuracy
   8 : Max Combo
   9 : Perfect Play
   10 : The number of total patterns
   11 : The number of patterns that recorded
   */
  
  /// The `enum` that defines formats.
  private enum Format {
    
    /// The format for representing average.
    static let average = "%05.2f%%"
  }
  
  // MARK: Property
  
  /// The stack view related to the 4B.
  @IBOutlet private weak var button4StackView: UIStackView!
  
  /// The stack view related to the 5B.
  @IBOutlet private weak var button5StackView: UIStackView!
  
  /// The stack view related to the 6B.
  @IBOutlet private weak var button6StackView: UIStackView!
  
  /// The stack view related to the 8B.
  @IBOutlet private weak var button8StackView: UIStackView!
  
  /// The stack view related to the all tunes.
  @IBOutlet private weak var allStackView: UIStackView!
  
  /// The results of songs.
  private var songResults: Results<SongInfo>!
  
  /// The results of records.
  private var recordResults: Results<RecordInfo>!
  
  /// The values about the 4B.
  private var button4Values = [Int](repeating: 0, count: 12)
  
  /// The values about the 5B.
  private var button5Values = [Int](repeating: 0, count: 12)
  
  /// The values about the 6B.
  private var button6Values = [Int](repeating: 0, count: 12)
  
  /// The values about the 8B.
  private var button8Values = [Int](repeating: 0, count: 12)
  
  /// The values about the all tunes.
  private var allValues = [Int](repeating: 0, count: 12)
  
  /// The values about the rating.
  private var ratingValues = [Double](repeating: 0.0, count: 5)
  
  // MARK: Life Cycle
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    calculateAllValuesAndReloadSubviews()
  }
  
  /// Tells the `sender` that the cancel button is tapped.
  @IBAction private func cancelButtonDidTap(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
}

// MARK: - Private Method

private extension SummaryDetailViewController {
  
  func calculateAllValuesAndReloadSubviews() {
    DispatchQueue.global().async { [weak self] in
      guard let self = self else { return }
      let buttons = Button.all.map { $0.expansion }.compactMap { $0 }
      let difficulties = Difficulty.all.map { $0.rawValue }
      self.songResults = SongInfo.fetch().sorted(byKeyPath: "title.english")
      self.recordResults = RecordInfo.fetch().sorted(byKeyPath: "title.english")
      zip(self.songResults, self.recordResults).forEach { songResult, recordResult in
        for index in 0..<4 {
          let button = buttons[index]
          guard let songButtonKeyPath
            = songResult.value(forKeyPath: button) as? SongButtonInfo else { return }
          guard let recordButtonKeyPath
            = recordResult.value(forKeyPath: button) as? RecordButtonInfo else { return }
          for difficulty in difficulties {
            guard let level
              = songButtonKeyPath.value(forKeyPath: difficulty) as? Int
              else { return }
            if level != 0 {
              guard let recordKeyPath
                = recordButtonKeyPath.value(forKeyPath: difficulty) as? RecordDifficultyInfo
                else { return }
              if !recordKeyPath.rank.isEmpty {
                switch index {
                case 0:
                  self.button4Values[11] += 1
                  self.ratingValues[0] += recordKeyPath.rate
                case 1:
                  self.button5Values[11] += 1
                  self.ratingValues[1] += recordKeyPath.rate
                case 2:
                  self.button6Values[11] += 1
                  self.ratingValues[2] += recordKeyPath.rate
                case 3:
                  self.button8Values[11] += 1
                  self.ratingValues[3] += recordKeyPath.rate
                default:
                  break
                }
              }
              guard let note = recordKeyPath.noteEnum else { return }
              switch note {
              case .maxCombo:
                switch index {
                case 0:
                  self.button4Values[8] += 1
                case 1:
                  self.button5Values[8] += 1
                case 2:
                  self.button6Values[8] += 1
                case 3:
                  self.button8Values[8] += 1
                default:
                  break
                }
              case .perfectPlay:
                switch index {
                case 0:
                  self.button4Values[9] += 1
                case 1:
                  self.button5Values[9] += 1
                case 2:
                  self.button6Values[9] += 1
                case 3:
                  self.button8Values[9] += 1
                default:
                  break
                }
              default:
                break
              }
              switch recordKeyPath.rate {
              case 99.8...100:
                switch index {
                case 0:
                  self.button4Values[0] += 1
                case 1:
                  self.button5Values[0] += 1
                case 2:
                  self.button6Values[0] += 1
                case 3:
                  self.button8Values[0] += 1
                default:
                  break
                }
              case 99.5..<99.8:
                switch index {
                case 0:
                  self.button4Values[1] += 1
                case 1:
                  self.button5Values[1] += 1
                case 2:
                  self.button6Values[1] += 1
                case 3:
                  self.button8Values[1] += 1
                default:
                  break
                }
              case 99..<99.5:
                switch index {
                case 0:
                  self.button4Values[2] += 1
                case 1:
                  self.button5Values[2] += 1
                case 2:
                  self.button6Values[2] += 1
                case 3:
                  self.button8Values[2] += 1
                default:
                  break
                }
              case 98.5..<99:
                switch index {
                case 0:
                  self.button4Values[3] += 1
                case 1:
                  self.button5Values[3] += 1
                case 2:
                  self.button6Values[3] += 1
                case 3:
                  self.button8Values[3] += 1
                default:
                  break
                }
              case 98..<98.5:
                switch index {
                case 0:
                  self.button4Values[4] += 1
                case 1:
                  self.button5Values[4] += 1
                case 2:
                  self.button6Values[4] += 1
                case 3:
                  self.button8Values[4] += 1
                default:
                  break
                }
              case 95..<98:
                switch index {
                case 0:
                  self.button4Values[5] += 1
                case 1:
                  self.button5Values[5] += 1
                case 2:
                  self.button6Values[5] += 1
                case 3:
                  self.button8Values[5] += 1
                default:
                  break
                }
              case 90..<95:
                switch index {
                case 0:
                  self.button4Values[6] += 1
                case 1:
                  self.button5Values[6] += 1
                case 2:
                  self.button6Values[6] += 1
                case 3:
                  self.button8Values[6] += 1
                default:
                  break
                }
              case ..<90:
                switch index {
                case 0:
                  self.button4Values[7] += 1
                case 1:
                  self.button5Values[7] += 1
                case 2:
                  self.button6Values[7] += 1
                case 3:
                  self.button8Values[7] += 1
                default:
                  break
                }
              default:
                break
              }
            }
          }
        }
      }
      (self.button4Values[10],
       self.button5Values[10],
       self.button6Values[10],
       self.button8Values[10])
        = self.numberOfTotalPatterns()
      for index in 0..<12 {
        self.allValues[index]
          = self.button4Values[index]
          + self.button5Values[index]
          + self.button6Values[index]
          + self.button8Values[index]
      }
      self.ratingValues[0] = self.ratingValues[0] / Double(self.button4Values[11])
      self.ratingValues[1] = self.ratingValues[1] / Double(self.button5Values[11])
      self.ratingValues[2] = self.ratingValues[2] / Double(self.button6Values[11])
      self.ratingValues[3] = self.ratingValues[3] / Double(self.button8Values[11])
      self.ratingValues[4]
        = (self.ratingValues[0]
          + self.ratingValues[1]
          + self.ratingValues[2]
          + self.ratingValues[3]) / 4
      let count = self.button4StackView.arrangedSubviews.count
      for index in 1..<count - 1 {
        guard let button4Label
          = self.button4StackView.arrangedSubviews[index] as? UILabel else { return }
        guard let button5Label = self.button5StackView.arrangedSubviews[index]
          as? UILabel else { return }
        guard let button6Label = self.button6StackView.arrangedSubviews[index]
          as? UILabel else { return }
        guard let button8Label = self.button8StackView.arrangedSubviews[index]
          as? UILabel else { return }
        guard let allLabel = self.allStackView.arrangedSubviews[index] as? UILabel else { return }
        button4Label.text = "\(self.button4Values[index - 1])"
        button5Label.text = "\(self.button5Values[index - 1])"
        button6Label.text = "\(self.button6Values[index - 1])"
        button8Label.text = "\(self.button8Values[index - 1])"
        allLabel.text = "\(self.allValues[index - 1])"
      }
      guard let button4AverageLabel = self.button4StackView.arrangedSubviews.last as? UILabel
        else { return }
      guard let button5AverageLabel = self.button5StackView.arrangedSubviews.last as? UILabel
        else { return }
      guard let button6AverageLabel = self.button6StackView.arrangedSubviews.last as? UILabel
        else { return }
      guard let button8AverageLabel = self.button8StackView.arrangedSubviews.last as? UILabel
        else { return }
      guard let allAverageLabel
        = self.allStackView.arrangedSubviews.last as? UILabel else { return }
      button4AverageLabel.text = String(format: Format.average, self.ratingValues[0])
      button5AverageLabel.text = String(format: Format.average, self.ratingValues[1])
      button6AverageLabel.text = String(format: Format.average, self.ratingValues[2])
      button8AverageLabel.text = String(format: Format.average, self.ratingValues[3])
      allAverageLabel.text = String(format: Format.average, self.ratingValues[4])
    }
  }
  
  func numberOfTotalPatterns() -> (Int, Int, Int, Int) {
    var (button4, button5, button6, button8) = (0, 0, 0, 0)
    for result in songResults {
      let buttons = Button.all.map { $0.expansion }.compactMap { $0 }
      let difficulties = Difficulty.all.map { $0.rawValue }
      buttons.enumerated().forEach { index, button in
        guard let buttonKeyPath = result.value(forKeyPath: button) as? SongButtonInfo
          else { return }
        for difficulty in difficulties {
          guard let level = buttonKeyPath.value(forKeyPath: difficulty) as? Int else { return }
          if level != 0 {
            switch index {
            case 0:
              button4 += 1
            case 1:
              button5 += 1
            case 2:
              button6 += 1
            case 3:
              button8 += 1
            default:
              break
            }
          }
        }
      }
    }
    return (button4, button5, button6, button8)
  }
}
