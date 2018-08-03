//
//  SkillPoint.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 3..
//  Copyright © 2018년 Presto. All rights reserved.
//

import Foundation

class Skill {
    
    static let button4SkillPoint = "button4SkillPoint"
    static let button4HighestSkillPointRate = "button4HighestSkillPointRate"
    static let button4HighestSkillPointDifficulty = "button4HighestSkillPointDifficulty"
    static let button4HighestSkillPointNote = "button4HighestSkillPointNote"
    static let button5SkillPoint = "button5SkillPoint"
    static let button5HighestSkillPointRate = "button5HighestSkillPointRate"
    static let button5HighestSkillPointDifficulty = "button5HighestSkillPointDifficulty"
    static let button5HighestSkillPointNote = "button5HighestSkillPointNote"
    static let button6SkillPoint = "button6SkillPoint"
    static let button6HighestSkillPointRate = "button6HighestSkillPointRate"
    static let button6HighestSkillPointDifficulty = "button6HighestSkillPointDifficulty"
    static let button6HighestSkillPointNote = "button6HighestSkillPointNote"
    static let button8SkillPoint = "button8SkillPoint"
    static let button8HighestSkillPointRate = "button8HighestSkillPointRate"
    static let button8HighestSkillPointDifficulty = "button8HighestSkillPointDifficulty"
    static let button8HighestSkillPointNote = "button8HighestSkillPointNote"
    
    //단일 스킬포인트 계산
    static func skillPoint(difficulty: Int, rate: String, note: String) -> Double {
        if difficulty == 0 {
            return 0
        }
        var skillPoint: Double
        let e = 2.71828
        let rate = Double(rate.split(separator: "%").first?.description ?? "") ?? 0
        let weight = Skill.weight(difficulty)
        if rate >= 80 {
            let temp = pow((rate - 80) / 20.0, e) + 1
            skillPoint = weight * 50 * temp
        } else {
            skillPoint = Double(weight * rate * 5.0) / 8.0
        }
        if note == "-" {
            skillPoint *= 0.9
        } else if note == Note.perfectPlay {
            skillPoint *= 1.05
        }
        skillPoint = (skillPoint * 100).rounded() / 100
        return skillPoint
    }
    
    //현재 데이터베이스로 얻을 수 있는 최대 스킬포인트 계산
    static func maxSkillPoint(button: String) -> Double {
        let results = SongInfo.get()
        var max: Double = 0
        var top50Difficulties = [Int]()
        switch button {
        case Buttons.button4:
            for result in results {
                guard let highest = [result.nm4, result.hd4, result.mx4].sorted().last else { return 0 }
                top50Difficulties.append(highest)
            }
        case Buttons.button5:
            for result in results {
                guard let highest = [result.nm5, result.hd5, result.mx5].sorted().last else { return 0 }
                top50Difficulties.append(highest)
            }
        case Buttons.button6:
            for result in results {
                guard let highest = [result.nm6, result.hd6, result.mx6].sorted().last else { return 0 }
                top50Difficulties.append(highest)
            }
        case Buttons.button8:
            for result in results {
                guard let highest = [result.nm8, result.hd8, result.mx8].sorted().last else { return 0 }
                top50Difficulties.append(highest)
            }
        default:
            break
        }
        top50Difficulties.sort()
        for difficulty in top50Difficulties {
            max += Skill.weight(difficulty) * 105
        }
        return max
    }
    
    //내 기록의 스킬포인트와 1등의 시리즈 계산
    static func mySkillPoint(button: String) -> (sum: Double, highestSeries: String) {
        func getSum(_ key: String) -> (sum: Double, highestSeries: String) {
            let record = RecordInfo.get().sorted(byKeyPath: key, ascending: false)
            var sum: Double = 0
            for index in 0..<50 {
                let skillPoint = record[index].value(forKey: key) as? Double ?? 0
                sum += skillPoint
            }
            UserDefaults.standard.set(sum, forKey: key)
            UserDefaults.standard.synchronize()
            return (sum, record.first?.series ?? "")
        }
        switch button {
        case Buttons.button4:
            return getSum("button4SkillPoint")
        case Buttons.button5:
            return getSum("button5SkillPoint")
        case Buttons.button6:
            return getSum("button6SkillPoint")
        case Buttons.button8:
            return getSum("button8SkillPoint")
        default:
            return (0, "")
        }
    }
    
    //스킬포인트 다시 계산하여 데이터베이스 갱신
    static func refresh() {
        let results = RecordInfo.get()
        for result in results {
            let normalButton4SkillPoint = Skill.skillPoint(difficulty: result.nm4, rate: result.nm4Rate, note: result.nm4Note)
            let hardButton4SkillPoint = Skill.skillPoint(difficulty: result.hd4, rate: result.hd4Rate, note: result.hd4Note)
            let maximumButton4SkillPoint = Skill.skillPoint(difficulty: result.mx4, rate: result.mx4Rate, note: result.mx4Note)
            guard let maxButton4SkillPoint = [normalButton4SkillPoint, hardButton4SkillPoint, maximumButton4SkillPoint].sorted().last else { return }
            RecordInfo.update(result, with: [button4SkillPoint: maxButton4SkillPoint])
            switch maximumButton4SkillPoint {
            case normalButton4SkillPoint:
                RecordInfo.update(result, with: [
                    button4HighestSkillPointRate: result.nm4Rate,
                    button4HighestSkillPointDifficulty: Difficulty.normal,
                    button4HighestSkillPointNote: result.nm4Note
                    ])
            case hardButton4SkillPoint:
                RecordInfo.update(result, with: [
                    button4HighestSkillPointRate: result.hd4Rate,
                    button4HighestSkillPointDifficulty: Difficulty.hard,
                    button4HighestSkillPointNote: result.hd4Note
                    ])
            case maximumButton4SkillPoint:
                RecordInfo.update(result, with: [
                    button4HighestSkillPointRate: result.mx4Rate,
                    button4HighestSkillPointDifficulty: Difficulty.maximum,
                    button4HighestSkillPointNote: result.mx4Note
                    ])
            default:
                break
            }
            let normalButton5SkillPoint = Skill.skillPoint(difficulty: result.nm5, rate: result.nm5Rate, note: result.nm5Note)
            let hardButton5SkillPoint = Skill.skillPoint(difficulty: result.hd5, rate: result.hd5Rate, note: result.hd5Note)
            let maximumButton5SkillPoint = Skill.skillPoint(difficulty: result.mx5, rate: result.mx5Rate, note: result.mx5Note)
            guard let maxButton5SkillPoint = [normalButton5SkillPoint, hardButton5SkillPoint, maximumButton5SkillPoint].sorted().last else { return }
            RecordInfo.update(result, with: [button5SkillPoint: maxButton5SkillPoint])
            switch maximumButton5SkillPoint {
            case normalButton5SkillPoint:
                RecordInfo.update(result, with: [
                    button5HighestSkillPointRate: result.nm5Rate,
                    button5HighestSkillPointDifficulty: Difficulty.normal,
                    button5HighestSkillPointNote: result.nm5Note
                    ])
            case hardButton5SkillPoint:
                RecordInfo.update(result, with: [
                    button5HighestSkillPointRate: result.hd5Rate,
                    button5HighestSkillPointDifficulty: Difficulty.hard,
                    button5HighestSkillPointNote: result.hd5Note
                    ])
            case maximumButton5SkillPoint:
                RecordInfo.update(result, with: [
                    button5HighestSkillPointRate: result.mx5Rate,
                    button5HighestSkillPointDifficulty: Difficulty.maximum,
                    button5HighestSkillPointNote: result.mx5Note
                    ])
            default:
                break
            }
            let normalButton6SkillPoint = Skill.skillPoint(difficulty: result.nm6, rate: result.nm6Rate, note: result.nm6Note)
            let hardButton6SkillPoint = Skill.skillPoint(difficulty: result.hd6, rate: result.hd6Rate, note: result.hd6Note)
            let maximumButton6SkillPoint = Skill.skillPoint(difficulty: result.mx6, rate: result.mx6Rate, note: result.mx6Note)
            guard let maxButton6SkillPoint = [normalButton6SkillPoint, hardButton6SkillPoint, maximumButton6SkillPoint].sorted().last else { return }
            RecordInfo.update(result, with: [button6SkillPoint: maxButton6SkillPoint])
            switch maximumButton6SkillPoint {
            case normalButton6SkillPoint:
                RecordInfo.update(result, with: [
                    button6HighestSkillPointRate: result.nm6Rate,
                    button6HighestSkillPointDifficulty: Difficulty.normal,
                    button6HighestSkillPointNote: result.nm6Note
                    ])
            case hardButton6SkillPoint:
                RecordInfo.update(result, with: [
                    button6HighestSkillPointRate: result.hd6Rate,
                    button6HighestSkillPointDifficulty: Difficulty.hard,
                    button6HighestSkillPointNote: result.hd6Note
                    ])
            case maximumButton6SkillPoint:
                RecordInfo.update(result, with: [
                    button6HighestSkillPointRate: result.mx6Rate,
                    button6HighestSkillPointDifficulty: Difficulty.maximum,
                    button6HighestSkillPointNote: result.mx6Note
                    ])
            default:
                break
            }
            let normalButton8SkillPoint = Skill.skillPoint(difficulty: result.nm8, rate: result.nm8Rate, note: result.nm8Note)
            let hardButton8SkillPoint = Skill.skillPoint(difficulty: result.hd8, rate: result.hd8Rate, note: result.hd8Note)
            let maximumButton8SkillPoint = Skill.skillPoint(difficulty: result.mx8, rate: result.mx8Rate, note: result.mx8Note)
            guard let maxButton8SkillPoint = [normalButton8SkillPoint, hardButton8SkillPoint, maximumButton8SkillPoint].sorted().last else { return }
            RecordInfo.update(result, with: [button8SkillPoint: maxButton8SkillPoint])
            switch maximumButton8SkillPoint {
            case normalButton8SkillPoint:
                RecordInfo.update(result, with: [
                    button8HighestSkillPointRate: result.nm8Rate,
                    button8HighestSkillPointDifficulty: Difficulty.normal,
                    button8HighestSkillPointNote: result.nm8Note
                    ])
            case hardButton8SkillPoint:
                RecordInfo.update(result, with: [
                    button8HighestSkillPointRate: result.hd8Rate,
                    button8HighestSkillPointDifficulty: Difficulty.hard,
                    button8HighestSkillPointNote: result.hd8Note
                    ])
            case maximumButton8SkillPoint:
                RecordInfo.update(result, with: [
                    button8HighestSkillPointRate: result.mx8Rate,
                    button8HighestSkillPointDifficulty: Difficulty.maximum,
                    button8HighestSkillPointNote: result.mx8Note
                    ])
            default:
                break
            }
        }
    }
    
    static func nextSkillLevel(of skillLevel: String, button: String) -> String? {
        var index: Int = 0
        var nextSkillLevel = "Next".localized + " : "
        switch button {
        case Buttons.button4:
            for element in SkillLevel.button4SkillLevels {
                if element == skillLevel { break }
                index += 1
            }
            if index + 1 == SkillLevel.button4SkillLevels.count {
                nextSkillLevel += "None".localized
            } else {
                nextSkillLevel += SkillLevel.button4SkillLevels[index + 1]
            }
        case Buttons.button5:
            for element in SkillLevel.button5SkillLevels {
                if element == skillLevel { break }
                index += 1
            }
            if index + 1 == SkillLevel.button5SkillLevels.count {
                nextSkillLevel += "None".localized
            } else {
                nextSkillLevel += SkillLevel.button5SkillLevels[index + 1]
            }
        case Buttons.button6, Buttons.button8:
            for element in SkillLevel.button6And8SkillLevels {
                if element == skillLevel { break }
                index += 1
            }
            if index + 1 == SkillLevel.button6And8SkillLevels.count {
                nextSkillLevel += "None".localized
            } else {
                nextSkillLevel += SkillLevel.button6And8SkillLevels[index + 1]
            }
        default:
            break
        }
        return nextSkillLevel
    }
    
    static func recordRate() -> (button4RecordRate: Double, button5RecordRate: Double, button6RecordRate: Double, button8RecordRate: Double) {
        var button4Count = [0, 0]
        var button5Count = [0, 0]
        var button6Count = [0, 0]
        var button8Count = [0, 0]
        let results = RecordInfo.get()
        for result in results {
            if result.nm4 != 0 {
                button4Count[0] += 1
            }
            if result.hd4 != 0 {
                button4Count[0] += 1
            }
            if result.mx4 != 0 {
                button4Count[0] += 1
            }
            if result.nm5 != 0 {
                button5Count[0] += 1
            }
            if result.hd5 != 0 {
                button5Count[0] += 1
            }
            if result.mx5 != 0 {
                button5Count[0] += 1
            }
            if result.nm6 != 0 {
                button6Count[0] += 1
            }
            if result.hd6 != 0 {
                button6Count[0] += 1
            }
            if result.mx6 != 0 {
                button6Count[0] += 1
            }
            if result.nm8 != 0 {
                button8Count[0] += 1
            }
            if result.hd8 != 0 {
                button8Count[0] += 1
            }
            if result.mx8 != 0 {
                button8Count[0] += 1
            }
            if let _ = Double(result.nm4Rate.split(separator: "%")[0]) {
                button4Count[1] += 1
            }
            if let _ = Double(result.hd4Rate.split(separator: "%")[0]) {
                button4Count[1] += 1
            }
            if let _ = Double(result.mx4Rate.split(separator: "%")[0]) {
                button4Count[1] += 1
            }
            if let _ = Double(result.nm5Rate.split(separator: "%")[0]) {
                button5Count[1] += 1
            }
            if let _ = Double(result.hd5Rate.split(separator: "%")[0]) {
                button5Count[1] += 1
            }
            if let _ = Double(result.mx5Rate.split(separator: "%")[0]) {
                button5Count[1] += 1
            }
            if let _ = Double(result.nm6Rate.split(separator: "%")[0]) {
                button6Count[1] += 1
            }
            if let _ = Double(result.hd6Rate.split(separator: "%")[0]) {
                button6Count[1] += 1
            }
            if let _ = Double(result.mx6Rate.split(separator: "%")[0]) {
                button6Count[1] += 1
            }
            if let _ = Double(result.nm8Rate.split(separator: "%")[0]) {
                button8Count[1] += 1
            }
            if let _ = Double(result.hd8Rate.split(separator: "%")[0]) {
                button8Count[1] += 1
            }
            if let _ = Double(result.mx8Rate.split(separator: "%")[0]) {
                button8Count[1] += 1
            }
        }
        let button4Rate = Double(button4Count[1]) / Double(button4Count[0])
        let button5Rate = Double(button5Count[1]) / Double(button5Count[0])
        let button6Rate = Double(button6Count[1]) / Double(button6Count[0])
        let button8Rate = Double(button8Count[1]) / Double(button8Count[0])
        return (button4Rate, button5Rate, button6Rate, button8Rate)
    }
    
}

extension Skill {
    static func button4SkillLevel(_ value: Double) -> String? {
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
    
    static func button5SkillLevel(_ value: Double) -> String? {
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
    
    static func button6And8SkillLevel(_ value: Double) -> String? {
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
    
    //스킬포인트 가중치 계산
    static func weight(_ value: Int) -> Double {
        switch value {
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