//
//  Utils.swift
//  RespectU
//
//  Created by Presto on 10/03/2019.
//  Copyright © 2019 Presto. All rights reserved.
//

import Foundation

/// The `class` that defines utility functions.
final class Utils {
  
  /// Calculates the skill point according to `difficulty`, `rate` and `note`.
  ///
  /// - Parameters:
  ///   - difficulty: The difficulty value.
  ///   - rate:       The rate value. It can be `nil`.
  ///   - note:       The note value.
  ///
  /// - Returns: The calculated skill point.
  static func skillPoint(difficulty: Int, rate: Double?, note: Note) -> Double {
    guard let rate = rate else { return 0 }
    if difficulty == 0 { return 0 }
    let naturalConstant = Double.naturalConstant
    let weight = Utils.weight(of: difficulty)
    var skillPoint: Double
    if rate >= 80 {
      let temp = pow((rate - 80) / 20, naturalConstant) + 1
      skillPoint = weight * 50 * temp
    } else {
      skillPoint = Double(weight * rate * 5) / 8
    }
    switch note {
    case .none:
      skillPoint *= 0.9
    case .perfectPlay:
      skillPoint *= 1.05
    default:
      break
    }
    skillPoint = (skillPoint * 100).rounded() / 100
    return skillPoint
  }
  
  /// Calculates the maximum skill point that can be earned in specific `button`.
  ///
  /// - Parameter button: The button.
  ///
  /// - Note: `xb`, `tb` is only in mission, so they cannot have the maximum skill point.
  ///
  /// - Returns: The calculated maximum skill point in specific `button`.
  static func maxSkillPoint(in button: Button) -> Double {
    let results = SongInfo.fetch()
    var maxSkillPoint: Double = 0
    var top50Difficulties: [Int] = []
    for songInfo in results {
      let songButtonInfo: SongButtonInfo?
      switch button {
      case .button4:
        songButtonInfo = songInfo.button4
      case .button5:
        songButtonInfo = songInfo.button5
      case .button6:
        songButtonInfo = songInfo.button6
      case .button8:
        songButtonInfo = songInfo.button8
      default:
        break
      }
      guard let bindedSongButtonInfo = songButtonInfo else { return 0 }
      guard let highestSkillPoint = [
        bindedSongButtonInfo.normal,
        bindedSongButtonInfo.hard,
        bindedSongButtonInfo.maximum
        ].sorted().last else { return 0 }
      top50Difficulties.append(highestSkillPoint)
    }
    top50Difficulties.sort(by: >)
    (0..<50).forEach { index in
      maxSkillPoint += Utils.weight(of: top50Difficulties[index]) * 105
    }
    return maxSkillPoint
  }
  
  static func totalSkillPointAndHighestSeries(in button: Button) -> (Double, Series) {
    
  }
  
  static func refresh() {
    let recordResults = RecordInfo.fetch()
    let songResults = SongInfo.fetch()
    
  }
  
  
  
  /// Converts `speed` to the recommended speed.
  ///
  /// - Parameter speed: The `speed` value.
  ///
  /// - Returns: The converted string matching each case.
  ///
  /// - Note: `3.14` -> `3.00 ~ 3.25`
  static func convertToRecommendedSpeed(by speed: Double) -> String? {
    switch speed {
    case ..<0.50:
      return "0.50"
    case 0.50..<0.75:
      return "0.50 ~ 0.75"
    case 0.75..<1.00:
      return "0.75 ~ 1.00"
    case 1.00..<1.25:
      return "1.00 ~ 1.25"
    case 1.25..<1.50:
      return "1.25 ~ 1.50"
    case 1.50..<1.75:
      return "1.50 ~ 1.75"
    case 1.75..<2.00:
      return "1.75 ~ 2.00"
    case 2.00..<2.25:
      return "2.00 ~ 2.25"
    case 2.25..<2.50:
      return "2.25 ~ 2.50"
    case 2.50..<2.75:
      return "2.50 ~ 2.75"
    case 2.75..<3.00:
      return "2.75 ~ 3.00"
    case 3.00..<3.25:
      return "3.00 ~ 3.25"
    case 3.25..<3.50:
      return "3.25 ~ 3.50"
    case 3.50..<3.75:
      return "3.50 ~ 3.75"
    case 3.75..<4.00:
      return "3.75 ~ 4.00"
    case 4.00..<4.25:
      return "4.00 ~ 4.25"
    case 4.25..<4.50:
      return "4.25 ~ 4.50"
    case 4.50..<4.75:
      return "4.50 ~ 4.75"
    case 4.75..<5.00:
      return "4.75 ~ 5.00"
    case 5.00...:
      return "5.00"
    default:
      return nil
    }
  }
  
  /// Converts `rate` contains percent symbol to `Double` value.
  ///
  /// - Parameter rate: The `rate` contains percent symbol.
  ///
  /// - Returns: The converted `rate` represented to `Double`.
  static func convertToDouble(withPercent rate: String) -> Double {
    if case let value? = rate.components(separatedBy: "%").first {
      return Double(value) ?? 0
    } else {
      return 0
    }
  }
  
  static func button4SkillLevel(of skillPoint: Double) -> String? {
    switch skillPoint {
    case 0..<1000:
      return SkillLevel.beginner
    case 1000..<1500:
      return SkillLevel.amateur4
    case 1500..<2000:
      return SkillLevel.amateur3
    case 2000..<2300:
      return SkillLevel.amateur2
    case 2300..<2600:
      return SkillLevel.amateur1
    case 2600..<3000:
      return SkillLevel.subDj4
    case 3000..<3300:
      return SkillLevel.subDj3
    case 3300..<3600:
      return SkillLevel.subDj2
    case 3600..<4000:
      return SkillLevel.subDj1
    case 4000..<4300:
      return SkillLevel.mainDj4
    case 4300..<4600:
      return SkillLevel.mainDj3
    case 4600..<5000:
      return SkillLevel.mainDj2
    case 5000..<5300:
      return SkillLevel.mainDj1
    case 5300..<5600:
      return SkillLevel.popDj4
    case 5600..<6000:
      return SkillLevel.popDj3
    case 6000..<6300:
      return SkillLevel.popDj2
    case 6300..<6600:
      return SkillLevel.popDj1
    case 6600..<7000:
      return SkillLevel.professional3
    case 7000..<7200:
      return SkillLevel.professional2
    case 7200..<7400:
      return SkillLevel.professional1
    case 7400..<7600:
      return SkillLevel.mixMaster3
    case 7600..<7800:
      return SkillLevel.mixMaster2
    case 7800..<8000:
      return SkillLevel.mixMaster1
    case 8000..<8200:
      return SkillLevel.superstar3
    case 8200..<8400:
      return SkillLevel.superstar2
    case 8400..<8600:
      return SkillLevel.superstar1
    case 8600..<8800:
      return SkillLevel.djmaxGrandMaster
    case 8800...:
      return SkillLevel.theDjmax
    default:
      return nil
    }
  }
  
  static func button5SkillLevel(of skillPoint: Double) -> String? {
    switch value {
    case 0..<1000:
      return SkillLevel.beginner
    case 1000..<1500:
      return SkillLevel.amateur4
    case 1500..<2000:
      return SkillLevel.amateur3
    case 2000..<2300:
      return SkillLevel.amateur2
    case 2300..<2600:
      return SkillLevel.amateur1
    case 2600..<3000:
      return SkillLevel.subDj4
    case 3000..<3300:
      return SkillLevel.subDj3
    case 3300..<3600:
      return SkillLevel.subDj2
    case 3600..<4000:
      return SkillLevel.subDj1
    case 4000..<4300:
      return SkillLevel.mainDj4
    case 4300..<4600:
      return SkillLevel.mainDj3
    case 4600..<5000:
      return SkillLevel.mainDj2
    case 5000..<5300:
      return SkillLevel.mainDj1
    case 5300..<5600:
      return SkillLevel.popDj4
    case 5600..<6000:
      return SkillLevel.popDj3
    case 6000..<6300:
      return SkillLevel.popDj2
    case 6300..<6600:
      return SkillLevel.popDj1
    case 6600..<7000:
      return SkillLevel.professional4
    case 7000..<7200:
      return SkillLevel.professional3
    case 7200..<7400:
      return SkillLevel.professional2
    case 7400..<7600:
      return SkillLevel.professional1
    case 7600..<7800:
      return SkillLevel.mixMaster3
    case 7800..<8000:
      return SkillLevel.mixMaster2
    case 8000..<8200:
      return SkillLevel.mixMaster1
    case 8200..<8400:
      return SkillLevel.superstar3
    case 8400..<8600:
      return SkillLevel.superstar2
    case 8600..<8800:
      return SkillLevel.superstar1
    case 8800..<9000:
      return SkillLevel.djmaxGrandMaster
    case 9000...:
      return SkillLevel.theDjmax
    default:
      return nil
    }
  }
  
  static func button6And8SkillLevel(of skillPoint: Double) -> String? {
    switch value {
    case 0..<1500:
      return SkillLevel.beginner
    case 1500..<2000:
      return SkillLevel.amateur4
    case 2000..<2300:
      return SkillLevel.amateur3
    case 2300..<2600:
      return SkillLevel.amateur2
    case 2600..<3000:
      return SkillLevel.amateur1
    case 3000..<3300:
      return SkillLevel.subDj4
    case 3300..<3600:
      return SkillLevel.subDj3
    case 3600..<4000:
      return SkillLevel.subDj2
    case 4000..<4300:
      return SkillLevel.subDj1
    case 4300..<4600:
      return SkillLevel.mainDj4
    case 4600..<5000:
      return SkillLevel.mainDj3
    case 5000..<5300:
      return SkillLevel.mainDj2
    case 5300..<5600:
      return SkillLevel.mainDj1
    case 5600..<6000:
      return SkillLevel.popDj4
    case 6000..<6300:
      return SkillLevel.popDj3
    case 6300..<6600:
      return SkillLevel.popDj2
    case 6600..<7000:
      return SkillLevel.popDj1
    case 7000..<7200:
      return SkillLevel.professional4
    case 7200..<7400:
      return SkillLevel.professional3
    case 7400..<7600:
      return SkillLevel.professional2
    case 7600..<7800:
      return SkillLevel.professional1
    case 7800..<8000:
      return SkillLevel.mixMaster3
    case 8000..<8200:
      return SkillLevel.mixMaster2
    case 8200..<8400:
      return SkillLevel.mixMaster1
    case 8400..<8600:
      return SkillLevel.superstar3
    case 8600..<8800:
      return SkillLevel.superstar2
    case 8800..<9000:
      return SkillLevel.superstar1
    case 9000..<9200:
      return SkillLevel.djmaxGrandMaster
    case 9200...:
      return SkillLevel.theDjmax
    default:
      return nil
    }
  }
  
  static func weight(of difficulty: Int) -> Double {
    switch difficulty {
    case 1:
      return 0.4
    case 2:
      return 0.6
    case 3:
      return 0.8
    case 4:
      return 1
    case 5:
      return 1.14
    case 6:
      return 1.24
    case 7:
      return 1.33
    case 8:
      return 1.42
    case 9:
      return 1.53
    case 10:
      return 1.6
    case 11:
      return 1.68
    case 12:
      return 1.77
    case 13:
      return 1.85
    case 14:
      return 1.94
    case 15:
      return 2
    default:
      return 0
    }

  }
}
