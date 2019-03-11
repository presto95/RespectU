////
////  SkillPoint.swift
////  RespectU
////
////  Created by Presto on 2018. 8. 3..
////  Copyright © 2018년 Presto. All rights reserved.
////
//
//import Foundation
//
//import RealmSwift
//
///// The utility `class` for calculating skill points.
//final class Skill {
//
//  /// 단일 스킬포인트 계산
//  static func skillPoint(difficulty: Int, rate: Double?, note: Note) -> Double {
//    guard let rate = rate else { return 0 }
//    if difficulty == 0 {
//      return 0
//    }
//    var skillPoint: Double
//    let naturalConstant = 2.71828
//    let weight = Skill.weight(difficulty)
//    if rate >= 80 {
//      let temp = pow((rate - 80) / 20.0, naturalConstant) + 1
//      skillPoint = weight * 50 * temp
//    } else {
//      skillPoint = Double(weight * rate * 5.0) / 8.0
//    }
//    switch note {
//    case .none:
//      skillPoint *= 0.0
//    case .perfectPlay:
//      skillPoint *= 1.05
//    default:
//      break
//    }
//    skillPoint = (skillPoint * 100).rounded() / 100
//    return skillPoint
//  }
//
//  /// 현재 데이터베이스로 얻을 수 있는 최대 스킬포인트 계산
//  static func maxSkillPoint(button: Button) -> Double {
//    let results = SongInfo.fetch()
//    var max: Double = 0
//    var top50Difficulties = [Int]()
//    for result in results {
//      let buttonResult: SongButtonInfo?
//      switch button {
//      case .button4:
//        buttonResult = result.button4
//      case .button5:
//        buttonResult = result.button5
//      case .button6:
//        buttonResult = result.button6
//      case .button8:
//        buttonResult = result.button8
//      default:
//        buttonResult = SongButtonInfo()
//      }
//      guard let bindedButtonResult = buttonResult else { return 0 }
//      guard let highest = [
//        bindedButtonResult.normal,
//        bindedButtonResult.hard,
//        bindedButtonResult.maximum
//        ].sorted().last else { return 0 }
//      top50Difficulties.append(highest)
//    }
//    top50Difficulties.sort(by: >)
//    for index in 0..<50 {
//      max += Skill.weight(top50Difficulties[index]) * 105
//    }
//    return max
//  }
//
//  /// 내 기록의 스킬포인트와 1등의 시리즈 계산
//  static func mySkillPointAndHighestSeries(button: Button) -> (sum: Double, highestSeries: String) {
//    func sumAndHighestSeries(_ results: Results<RecordInfo>?,
//                             button: Button) -> (sum: Double, highestSeries: String) {
//      guard let results = results else { return (0, "") }
//      var sum: Double = 0
//      for index in 0..<50 {
//        var skillPoint: Double = 0
//        switch button {
//        case .button4:
//          skillPoint = results[index].button4?.skillPoint ?? 0
//        case .button5:
//          skillPoint = results[index].button5?.skillPoint ?? 0
//        case .button6:
//          skillPoint = results[index].button6?.skillPoint ?? 0
//        case .button8:
//          skillPoint = results[index].button8?.skillPoint ?? 0
//        default:
//          break
//        }
//        sum += skillPoint
//      }
//      switch button {
//      case .button4:
//        UserDefaults.standard.set(sum, forKey: SkillPoint.button4)
//      case .button5:
//        UserDefaults.standard.set(sum, forKey: SkillPoint.button5)
//      case .button6:
//        UserDefaults.standard.set(sum, forKey: SkillPoint.button6)
//      case .button8:
//        UserDefaults.standard.set(sum, forKey: SkillPoint.button8)
//      default:
//        break
//      }
//      UserDefaults.standard.synchronize()
//      return (sum, results.first?.series ?? "")
//    }
//    let results: Results<RecordInfo>?
//    switch button {
//    case .button4:
//      results = RecordInfo.fetch().sorted(byKeyPath: "button4.skillPoint", ascending: false)
//      return sumAndHighestSeries(results, button: .button4)
//    case .button5:
//      results = RecordInfo.fetch().sorted(byKeyPath: "button5.skillPoint", ascending: false)
//      return sumAndHighestSeries(results, button: .button5)
//    case .button6:
//      results = RecordInfo.fetch().sorted(byKeyPath: "button6.skillPoint", ascending: false)
//      return sumAndHighestSeries(results, button: .button6)
//    case .button8:
//      results = RecordInfo.fetch().sorted(byKeyPath: "button8.skillPoint", ascending: false)
//      return sumAndHighestSeries(results, button: .button8)
//    default:
//      return (0, "")
//    }
//  }
//
//  /// 스킬포인트 다시 계산하여 데이터베이스 갱신
//  static func refresh() {
//    let recordResults = RecordInfo.fetch()
//    let songResults = SongInfo.fetch()
//    for recordResult in recordResults {
//      let predicate = NSPredicate(format: "%K == %@",
//                                  #keyPath(RecordInfo.title.english),
//                                  recordResult.title?.english ?? "")
//      guard let songResult = songResults.filter(predicate).first else { return }
//      let buttons = ["button4", "button5", "button6", "button8"]
//      for button in buttons {
//        guard let recordButtonResult = recordResult.value(forKey: button) as? RecordButtonInfo
//          else { return }
//        guard let songButtonResult = songResult.value(forKey: button) as? SongButtonInfo
//          else { return }
//        let recordNormal = recordButtonResult.normal
//        let recordHard = recordButtonResult.hard
//        let recordMaximum = recordButtonResult.maximum
//        let songNormal = songButtonResult.normal
//        let songHard = songButtonResult.hard
//        let songMaximum = songButtonResult.maximum
//        let normalSkillPoint = Skill.skillPoint(difficulty: songNormal,
//                                                rate: recordNormal?.rate,
//                                                note: Note(rawValue: recordNormal?.note ?? "") ?? .none)
//        let hardSkillPoint = Skill.skillPoint(difficulty: songHard,
//                                              rate: recordHard?.rate,
//                                              note: Note(rawValue: recordHard?.note ?? "") ?? .none)
//        let maximumSkillPoint = Skill.skillPoint(difficulty: songMaximum,
//                                                 rate: recordMaximum?.rate,
//                                                 note: Note(rawValue: recordMaximum?.note ?? "") ?? .none)
//        guard let maxSkillPoint = [normalSkillPoint, hardSkillPoint, maximumSkillPoint]
//          .sorted().last else { return }
//        RecordInfo.update(recordResult, with: ["\(button).skillPoint": maxSkillPoint])
//        switch maxSkillPoint {
//        case normalSkillPoint:
//          RecordInfo.update(recordResult, with: [
//            "\(button).skillPointDifficulty": Difficulty.normal,
//            "\(button).skillPointRate": recordNormal?.rate ?? 0,
//            "\(button).skillPointNote": recordNormal?.note ?? Note.none
//            ])
//        case hardSkillPoint:
//          RecordInfo.update(recordResult, with: [
//            "\(button).skillPointDifficulty": Difficulty.hard,
//            "\(button).skillPointRate": recordHard?.rate ?? 0,
//            "\(button).skillPointNote": recordHard?.note ?? Note.none
//            ])
//        case maximumSkillPoint:
//          RecordInfo.update(recordResult, with: [
//            "\(button).skillPointDifficulty": Difficulty.maximum,
//            "\(button).skillPointRate": recordMaximum?.rate ?? 0,
//            "\(button).skillPointNote": recordMaximum?.note ?? Note.none
//            ])
//        default:
//          break
//        }
//      }
//
//    }
//  }
//
//  /// 버튼별 현재 스킬레벨의 다음 단계 가져오기
//  static func nextSkillLevel(of skillLevel: String, button: Button) -> String? {
//    var index: Int = 0
//    var nextSkillLevel = "Next".localized + " : "
//    switch button {
//    case .button4:
//      for element in SkillLevel.button4SkillLevels {
//        if element == skillLevel { break }
//        index += 1
//      }
//      if index + 1 == SkillLevel.button4SkillLevels.count {
//        nextSkillLevel += "None".localized
//      } else {
//        nextSkillLevel += SkillLevel.button4SkillLevels[index + 1]
//      }
//    case .button5:
//      for element in SkillLevel.button5SkillLevels {
//        if element == skillLevel { break }
//        index += 1
//      }
//      if index + 1 == SkillLevel.button5SkillLevels.count {
//        nextSkillLevel += "None".localized
//      } else {
//        nextSkillLevel += SkillLevel.button5SkillLevels[index + 1]
//      }
//    case .button6, .button8:
//      for element in SkillLevel.button6And8SkillLevels {
//        if element == skillLevel { break }
//        index += 1
//      }
//      if index + 1 == SkillLevel.button6And8SkillLevels.count {
//        nextSkillLevel += "None".localized
//      } else {
//        nextSkillLevel += SkillLevel.button6And8SkillLevels[index + 1]
//      }
//    default:
//      break
//    }
//    return nextSkillLevel
//  }
//
//  /// 성과 기록 비율 계산
//  static func recordRate(button: Button) -> Double {
//    var counts = [0, 0]
//    let recordResults = RecordInfo.fetch()
//    let songResults = SongInfo.fetch()
//    for result in recordResults {
//      let buttonResult: RecordButtonInfo?
//      let songResult: SongButtonInfo?
//      let predicate = NSPredicate(format: "%K == %@",
//                                  #keyPath(SongInfo.title.english),
//                                  result.title?.english ?? "")
//      guard let filteredSong = songResults.filter(predicate).first else { return 0 }
//      switch button {
//      case .button4:
//        buttonResult = result.button4
//        songResult = filteredSong.button4
//      case .button5:
//        buttonResult = result.button5
//        songResult = filteredSong.button5
//      case .button6:
//        buttonResult = result.button6
//        songResult = filteredSong.button6
//      case .button8:
//        buttonResult = result.button8
//        songResult = filteredSong.button8
//      default:
//        buttonResult = RecordButtonInfo()
//        songResult = SongButtonInfo()
//      }
//      if songResult?.normal != 0 {
//        counts[0] += 1
//      }
//      if songResult?.hard != 0 {
//        counts[0] += 1
//      }
//      if songResult?.maximum != 0 {
//        counts[0] += 1
//      }
//      if buttonResult?.normal?.rate != 0 {
//        counts[1] += 1
//      }
//      if buttonResult?.hard?.rate != 0 {
//        counts[1] += 1
//      }
//      if buttonResult?.maximum?.rate != 0 {
//        counts[1] += 1
//      }
//    }
//    let rate = Double(counts[1]) / Double(counts[0])
//    return rate
//  }
//}
//
//extension Skill {
//
//  /// 4버튼 스킬 레벨 반환
//  static func button4SkillLevel(_ value: Double) -> String? {
//    switch value {
//    case 0..<1000:
//      return SkillLevel.beginner
//    case 1000..<1500:
//      return SkillLevel.amateur4
//    case 1500..<2000:
//      return SkillLevel.amateur3
//    case 2000..<2300:
//      return SkillLevel.amateur2
//    case 2300..<2600:
//      return SkillLevel.amateur1
//    case 2600..<3000:
//      return SkillLevel.subDj4
//    case 3000..<3300:
//      return SkillLevel.subDj3
//    case 3300..<3600:
//      return SkillLevel.subDj2
//    case 3600..<4000:
//      return SkillLevel.subDj1
//    case 4000..<4300:
//      return SkillLevel.mainDj4
//    case 4300..<4600:
//      return SkillLevel.mainDj3
//    case 4600..<5000:
//      return SkillLevel.mainDj2
//    case 5000..<5300:
//      return SkillLevel.mainDj1
//    case 5300..<5600:
//      return SkillLevel.popDj4
//    case 5600..<6000:
//      return SkillLevel.popDj3
//    case 6000..<6300:
//      return SkillLevel.popDj2
//    case 6300..<6600:
//      return SkillLevel.popDj1
//    case 6600..<7000:
//      return SkillLevel.professional3
//    case 7000..<7200:
//      return SkillLevel.professional2
//    case 7200..<7400:
//      return SkillLevel.professional1
//    case 7400..<7600:
//      return SkillLevel.mixMaster3
//    case 7600..<7800:
//      return SkillLevel.mixMaster2
//    case 7800..<8000:
//      return SkillLevel.mixMaster1
//    case 8000..<8200:
//      return SkillLevel.superstar3
//    case 8200..<8400:
//      return SkillLevel.superstar2
//    case 8400..<8600:
//      return SkillLevel.superstar1
//    case 8600..<8800:
//      return SkillLevel.djmaxGrandMaster
//    case 8800...:
//      return SkillLevel.theDjmax
//    default:
//      return nil
//    }
//  }
//
//  /// 5버튼 스킬 레벨 반환
//  static func button5SkillLevel(_ value: Double) -> String? {
//    switch value {
//    case 0..<1000:
//      return SkillLevel.beginner
//    case 1000..<1500:
//      return SkillLevel.amateur4
//    case 1500..<2000:
//      return SkillLevel.amateur3
//    case 2000..<2300:
//      return SkillLevel.amateur2
//    case 2300..<2600:
//      return SkillLevel.amateur1
//    case 2600..<3000:
//      return SkillLevel.subDj4
//    case 3000..<3300:
//      return SkillLevel.subDj3
//    case 3300..<3600:
//      return SkillLevel.subDj2
//    case 3600..<4000:
//      return SkillLevel.subDj1
//    case 4000..<4300:
//      return SkillLevel.mainDj4
//    case 4300..<4600:
//      return SkillLevel.mainDj3
//    case 4600..<5000:
//      return SkillLevel.mainDj2
//    case 5000..<5300:
//      return SkillLevel.mainDj1
//    case 5300..<5600:
//      return SkillLevel.popDj4
//    case 5600..<6000:
//      return SkillLevel.popDj3
//    case 6000..<6300:
//      return SkillLevel.popDj2
//    case 6300..<6600:
//      return SkillLevel.popDj1
//    case 6600..<7000:
//      return SkillLevel.professional4
//    case 7000..<7200:
//      return SkillLevel.professional3
//    case 7200..<7400:
//      return SkillLevel.professional2
//    case 7400..<7600:
//      return SkillLevel.professional1
//    case 7600..<7800:
//      return SkillLevel.mixMaster3
//    case 7800..<8000:
//      return SkillLevel.mixMaster2
//    case 8000..<8200:
//      return SkillLevel.mixMaster1
//    case 8200..<8400:
//      return SkillLevel.superstar3
//    case 8400..<8600:
//      return SkillLevel.superstar2
//    case 8600..<8800:
//      return SkillLevel.superstar1
//    case 8800..<9000:
//      return SkillLevel.djmaxGrandMaster
//    case 9000...:
//      return SkillLevel.theDjmax
//    default:
//      return nil
//    }
//  }
//
//  /// 6, 8버튼 스킬 레벨 반환
//  static func button6And8SkillLevel(_ value: Double) -> String? {
//    switch value {
//    case 0..<1500:
//      return SkillLevel.beginner
//    case 1500..<2000:
//      return SkillLevel.amateur4
//    case 2000..<2300:
//      return SkillLevel.amateur3
//    case 2300..<2600:
//      return SkillLevel.amateur2
//    case 2600..<3000:
//      return SkillLevel.amateur1
//    case 3000..<3300:
//      return SkillLevel.subDj4
//    case 3300..<3600:
//      return SkillLevel.subDj3
//    case 3600..<4000:
//      return SkillLevel.subDj2
//    case 4000..<4300:
//      return SkillLevel.subDj1
//    case 4300..<4600:
//      return SkillLevel.mainDj4
//    case 4600..<5000:
//      return SkillLevel.mainDj3
//    case 5000..<5300:
//      return SkillLevel.mainDj2
//    case 5300..<5600:
//      return SkillLevel.mainDj1
//    case 5600..<6000:
//      return SkillLevel.popDj4
//    case 6000..<6300:
//      return SkillLevel.popDj3
//    case 6300..<6600:
//      return SkillLevel.popDj2
//    case 6600..<7000:
//      return SkillLevel.popDj1
//    case 7000..<7200:
//      return SkillLevel.professional4
//    case 7200..<7400:
//      return SkillLevel.professional3
//    case 7400..<7600:
//      return SkillLevel.professional2
//    case 7600..<7800:
//      return SkillLevel.professional1
//    case 7800..<8000:
//      return SkillLevel.mixMaster3
//    case 8000..<8200:
//      return SkillLevel.mixMaster2
//    case 8200..<8400:
//      return SkillLevel.mixMaster1
//    case 8400..<8600:
//      return SkillLevel.superstar3
//    case 8600..<8800:
//      return SkillLevel.superstar2
//    case 8800..<9000:
//      return SkillLevel.superstar1
//    case 9000..<9200:
//      return SkillLevel.djmaxGrandMaster
//    case 9200...:
//      return SkillLevel.theDjmax
//    default:
//      return nil
//    }
//  }
//
//  /// 스킬포인트 가중치 계산
//  static func weight(_ value: Int) -> Double {
//    switch value {
//    case 1:
//      return 0.4
//    case 2:
//      return 0.6
//    case 3:
//      return 0.8
//    case 4:
//      return 1
//    case 5:
//      return 1.14
//    case 6:
//      return 1.24
//    case 7:
//      return 1.33
//    case 8:
//      return 1.42
//    case 9:
//      return 1.53
//    case 10:
//      return 1.6
//    case 11:
//      return 1.68
//    case 12:
//      return 1.77
//    case 13:
//      return 1.85
//    case 14:
//      return 1.94
//    case 15:
//      return 2
//    default:
//      return 0
//    }
//  }
//}
