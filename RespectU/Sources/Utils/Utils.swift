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
        songButtonInfo = nil
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
  
  /// Calculates the total skill point in `button`
  /// and returns the series of the highest skill point.
  ///
  /// - Parameters:
  ///   - button: The specific button.
  ///
  /// - Returns: The total skill point and the highest series in specific `button`.
  static func totalSkillPointAndHighestSeries(in button: Button) -> (Double, Series?) {
    let results = RecordInfo.fetch()
    switch button {
    case .button4:
      let sorted = results.sorted(byKeyPath: "button4.skillPoint")
      let totalSkillPoint = sorted[0..<50].map { $0.button4?.skillPoint ?? 0 }.reduce(0, +)
      let highestSeries = Series(rawValue: sorted.first?.series ?? "")
      UserDefaults.standard.do {
        $0.set(totalSkillPoint, forKey: SkillPoint.button4)
        $0.synchronize()
      }
      return (totalSkillPoint, highestSeries)
    case .button5:
      let sorted = results.sorted(byKeyPath: "button5.skillPoint")
      let totalSkillPoint = sorted[0..<50].map { $0.button5?.skillPoint ?? 0 }.reduce(0, +)
      let highestSeries = Series(rawValue: sorted.first?.series ?? "")
      UserDefaults.standard.do {
        $0.set(totalSkillPoint, forKey: SkillPoint.button5)
        $0.synchronize()
      }
      return (totalSkillPoint, highestSeries)
    case .button6:
      let sorted = results.sorted(byKeyPath: "button6.skillPoint")
      let totalSkillPoint = sorted[0..<50].map { $0.button6?.skillPoint ?? 0 }.reduce(0, +)
      let highestSeries = Series(rawValue: sorted.first?.series ?? "")
      UserDefaults.standard.do {
        $0.set(totalSkillPoint, forKey: SkillPoint.button6)
        $0.synchronize()
      }
      return (totalSkillPoint, highestSeries)
    case .button8:
      let sorted = results.sorted(byKeyPath: "button8.skillPoint")
      let totalSkillPoint = sorted[0..<50].map { $0.button8?.skillPoint ?? 0 }.reduce(0, +)
      let highestSeries = Series(rawValue: sorted.first?.series ?? "")
      UserDefaults.standard.do {
        $0.set(totalSkillPoint, forKey: SkillPoint.button8)
        $0.synchronize()
      }
      return (totalSkillPoint, highestSeries)
    default:
      return (0, nil)
    }
  }
  
  /// Re-calculates all skill points and updates.
  static func refreshSkillPoints() {
    let recordResults = RecordInfo.fetch().sorted(byKeyPath: "title.english")
    let songResults = SongInfo.fetch().sorted(byKeyPath: "title.english")
    zip(recordResults, songResults).forEach { recordInfo, songInfo in
      let buttons = ["button4", "button5", "button6", "button8"]
      for button in buttons {
        guard let recordButtonInfo = recordInfo.value(forKey: button) as? RecordButtonInfo
          else { return }
        guard let songButtonInfo = songInfo.value(forKey: button) as? SongButtonInfo
          else { return }
        let normalRecord = recordButtonInfo.normal
        let hardRecord = recordButtonInfo.hard
        let maximumRecord = recordButtonInfo.maximum
        let normalDifficulty = songButtonInfo.normal
        let hardDifficulty = songButtonInfo.hard
        let maximumDifficulty = songButtonInfo.maximum
        let normalSkillPoint = Utils
          .skillPoint(difficulty: normalDifficulty,
                      rate: normalRecord?.rate,
                      note: Note(rawValue: normalRecord?.note ?? "") ?? .none)
        let hardSkillPoint = Utils
          .skillPoint(difficulty: hardDifficulty,
                      rate: hardRecord?.rate,
                      note: Note(rawValue: hardRecord?.note ?? "") ?? .none)
        let maximumSkillPoint = Utils
          .skillPoint(difficulty: maximumDifficulty,
                      rate: maximumRecord?.rate,
                      note: Note(expansion: maximumRecord?.note ?? "") ?? .none)
        guard let maxSkillPoint
          = [normalSkillPoint, hardSkillPoint, maximumSkillPoint].sorted().last
          else { return }
        switch maxSkillPoint {
        case normalSkillPoint:
          RecordInfo.update(recordInfo, with: [
            "\(button).skillPointDifficulty": Difficulty.hard.rawValue,
            "\(button).skillPointRate": normalRecord?.rate ?? 0,
            "\(button).skillPointNote": normalRecord?.note ?? Note.none.rawValue
            ])
        case hardSkillPoint:
          RecordInfo.update(recordInfo, with: [
            "\(button).skillPointDifficulty": Difficulty.hard.rawValue,
            "\(button).skillPointRate": normalRecord?.rate ?? 0,
            "\(button).skillPointNote": normalRecord?.note ?? Note.none.rawValue
            ])
        case maximumSkillPoint:
          RecordInfo.update(recordInfo, with: [
            "\(button).skillPointDifficulty": Difficulty.maximum.rawValue,
            "\(button).skillPointRate": normalRecord?.rate ?? 0,
            "\(button).skillPointNote": normalRecord?.note ?? Note.none.rawValue
            ])
        default:
          break
        }
      }
    }
  }
  
  /// Fetches next skill level of `skillLevel` in `button`.
  ///
  /// - Parameters:
  ///   - skillLevel: The current skill level.
  ///   - button:     The specific button.
  ///
  /// - Returns: The fetched next skill level.
  ///
  /// - Note: It can return `nil`. In this case, there is no next level.
  static func nextSkillLevel(of skillLevel: SkillLevel, in button: Button) -> SkillLevel? {
    let skillLevels: [SkillLevel]
    switch button {
    case .button4:
      skillLevels = SkillLevel.button4SkillLevels
    case .button5:
      skillLevels = SkillLevel.button5SkillLevels
    case .button6, .button8:
      skillLevels = SkillLevel.button6And8SkillLevels
    default:
      return nil
    }
    let index = skillLevels.firstIndex(of: skillLevel) ?? 0
    if index + 1 == skillLevels.count {
      return nil
    } else {
      return skillLevels[index + 1]
    }
  }
  
  /// Calculates the rate of saved records by total songs in specific `button`.
  ///
  /// - Parameter button: The specific button.
  ///
  /// - Returns: The calculated rate.
  static func recordRate(in button: Button) -> Double {
    var (portion, entire) = (0, 0)
    let recordResults = RecordInfo.fetch().sorted(byKeyPath: "title.english")
    let songResults = SongInfo.fetch().sorted(byKeyPath: "title.english")
    zip(recordResults, songResults).forEach { recordInfo, songInfo in
      let recordButtonInfo: RecordButtonInfo?
      let songButtonInfo: SongButtonInfo?
      switch button {
      case .button4:
        recordButtonInfo = recordInfo.button4
        songButtonInfo = songInfo.button4
      case .button5:
        recordButtonInfo = recordInfo.button5
        songButtonInfo = songInfo.button5
      case .button6:
        recordButtonInfo = recordInfo.button6
        songButtonInfo = songInfo.button6
      case .button8:
        recordButtonInfo = recordInfo.button8
        songButtonInfo = songInfo.button8
      default:
        recordButtonInfo = nil
        songButtonInfo = nil
      }
      if songButtonInfo?.normal != 0 {
        entire += 1
      }
      if songButtonInfo?.hard != 0 {
        entire += 1
      }
      if songButtonInfo?.maximum != 0 {
        entire += 1
      }
      if recordButtonInfo?.normal?.rate != 0 {
        portion += 1
      }
      if recordButtonInfo?.hard?.rate != 0 {
        portion += 1
      }
      if recordButtonInfo?.maximum?.rate != 0 {
        portion += 1
      }
    }
    return Double(portion) / Double(entire)
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
    case ..<0.50: return "0.50"
    case 0.50..<0.75: return "0.50 ~ 0.75"
    case 0.75..<1.00: return "0.75 ~ 1.00"
    case 1.00..<1.25: return "1.00 ~ 1.25"
    case 1.25..<1.50: return "1.25 ~ 1.50"
    case 1.50..<1.75: return "1.50 ~ 1.75"
    case 1.75..<2.00: return "1.75 ~ 2.00"
    case 2.00..<2.25: return "2.00 ~ 2.25"
    case 2.25..<2.50: return "2.25 ~ 2.50"
    case 2.50..<2.75: return "2.50 ~ 2.75"
    case 2.75..<3.00: return "2.75 ~ 3.00"
    case 3.00..<3.25: return "3.00 ~ 3.25"
    case 3.25..<3.50: return "3.25 ~ 3.50"
    case 3.50..<3.75: return "3.50 ~ 3.75"
    case 3.75..<4.00: return "3.75 ~ 4.00"
    case 4.00..<4.25: return "4.00 ~ 4.25"
    case 4.25..<4.50: return "4.25 ~ 4.50"
    case 4.50..<4.75: return "4.50 ~ 4.75"
    case 4.75..<5.00: return "4.75 ~ 5.00"
    case 5.00...: return "5.00"
    default: return nil
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
    }
    return 0
  }
  
  /// Accesses the skill level of 4B of `skillPoint`.
  ///
  /// - Parameter skillPoint: The given skill point.
  ///
  /// - Returns: The fetched skill level of 4B.
  static func button4SkillLevel(of skillPoint: Double) -> SkillLevel? {
    switch skillPoint {
    case 0..<1000: return .beginner
    case 1000..<1500: return .amateur4
    case 1500..<2000: return .amateur3
    case 2000..<2300: return .amateur2
    case 2300..<2600: return .amateur1
    case 2600..<3000: return .subDj4
    case 3000..<3300: return .subDj3
    case 3300..<3600: return .subDj2
    case 3600..<4000: return .subDj1
    case 4000..<4300: return .mainDj4
    case 4300..<4600: return .mainDj3
    case 4600..<5000: return .mainDj2
    case 5000..<5300: return .mainDj1
    case 5300..<5600: return .popDj4
    case 5600..<6000: return .popDj3
    case 6000..<6300: return .popDj2
    case 6300..<6600: return .popDj1
    case 6600..<7000: return .professional3
    case 7000..<7200: return .professional2
    case 7200..<7400: return .professional1
    case 7400..<7600: return .mixMaster3
    case 7600..<7800: return .mixMaster2
    case 7800..<8000: return .mixMaster1
    case 8000..<8200: return .superstar3
    case 8200..<8400: return .superstar2
    case 8400..<8600: return .superstar1
    case 8600..<8800: return .djmaxGrandMaster
    case 8800...: return .theDjmax
    default: return nil
    }
  }
  
  /// Accesses the skill level of 5B of `skillPoint`.
  ///
  /// - Parameter skillPoint: The given skill point.
  ///
  /// - Returns: The fetched skill level of 5B.
  static func button5SkillLevel(of skillPoint: Double) -> SkillLevel? {
    switch skillPoint {
    case 0..<1000: return .beginner
    case 1000..<1500: return .amateur4
    case 1500..<2000: return .amateur3
    case 2000..<2300: return .amateur2
    case 2300..<2600: return .amateur1
    case 2600..<3000: return .subDj4
    case 3000..<3300: return .subDj3
    case 3300..<3600: return .subDj2
    case 3600..<4000: return .subDj1
    case 4000..<4300: return .mainDj4
    case 4300..<4600: return .mainDj3
    case 4600..<5000: return .mainDj2
    case 5000..<5300: return .mainDj1
    case 5300..<5600: return .popDj4
    case 5600..<6000: return .popDj3
    case 6000..<6300: return .popDj2
    case 6300..<6600: return .popDj1
    case 6600..<7000: return .professional4
    case 7000..<7200: return .professional3
    case 7200..<7400: return .professional2
    case 7400..<7600: return .professional1
    case 7600..<7800: return .mixMaster3
    case 7800..<8000: return .mixMaster2
    case 8000..<8200: return .mixMaster1
    case 8200..<8400: return .superstar3
    case 8400..<8600: return .superstar2
    case 8600..<8800: return .superstar1
    case 8800..<9000: return .djmaxGrandMaster
    case 9000...: return .theDjmax
    default: return nil
    }
  }
  
  /// Accesses the skill level of 6B and 8B of `skillPoint`.
  ///
  /// - Parameter skillPoint: The given skill point.
  ///
  /// - Returns: The fetched skill level of 6B and 8B.
  static func button6And8SkillLevel(of skillPoint: Double) -> SkillLevel? {
    switch skillPoint {
    case 0..<1500: return .beginner
    case 1500..<2000: return .amateur4
    case 2000..<2300: return .amateur3
    case 2300..<2600: return .amateur2
    case 2600..<3000: return .amateur1
    case 3000..<3300: return .subDj4
    case 3300..<3600: return .subDj3
    case 3600..<4000: return .subDj2
    case 4000..<4300: return .subDj1
    case 4300..<4600: return .mainDj4
    case 4600..<5000: return .mainDj3
    case 5000..<5300: return .mainDj2
    case 5300..<5600: return .mainDj1
    case 5600..<6000: return .popDj4
    case 6000..<6300: return .popDj3
    case 6300..<6600: return .popDj2
    case 6600..<7000: return .popDj1
    case 7000..<7200: return .professional4
    case 7200..<7400: return .professional3
    case 7400..<7600: return .professional2
    case 7600..<7800: return .professional1
    case 7800..<8000: return .mixMaster3
    case 8000..<8200: return .mixMaster2
    case 8200..<8400: return .mixMaster1
    case 8400..<8600: return .superstar3
    case 8600..<8800: return .superstar2
    case 8800..<9000: return .superstar1
    case 9000..<9200: return .djmaxGrandMaster
    case 9200...: return .theDjmax
    default: return nil
    }
  }
  
  /// Accesses the weight of specific `difficulty`.
  ///
  /// - Parameter difficulty: The given difficulty.
  ///
  /// - Returns: The weight of given `difficulty`.
  static func weight(of difficulty: Int) -> Double {
    switch difficulty {
    case 1: return 0.4
    case 2: return 0.6
    case 3: return 0.8
    case 4: return 1
    case 5: return 1.14
    case 6: return 1.24
    case 7: return 1.33
    case 8: return 1.42
    case 9: return 1.53
    case 10: return 1.6
    case 11: return 1.68
    case 12: return 1.77
    case 13: return 1.85
    case 14: return 1.94
    case 15: return 2
    default: return 0
    }
  }
}
