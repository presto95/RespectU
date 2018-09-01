//
//  SkillPoint.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 3..
//  Copyright © 2018년 Presto. All rights reserved.
//

import Foundation
import RealmSwift

class Skill {
//
    static let button4SkillPoint = "button4SkillPoint"
//    static let button4HighestSkillPointRate = "button4HighestSkillPointRate"
//    static let button4HighestSkillPointDifficulty = "button4HighestSkillPointDifficulty"
//    static let button4HighestSkillPointNote = "button4HighestSkillPointNote"
    static let button5SkillPoint = "button5SkillPoint"
//    static let button5HighestSkillPointRate = "button5HighestSkillPointRate"
//    static let button5HighestSkillPointDifficulty = "button5HighestSkillPointDifficulty"
//    static let button5HighestSkillPointNote = "button5HighestSkillPointNote"
    static let button6SkillPoint = "button6SkillPoint"
//    static let button6HighestSkillPointRate = "button6HighestSkillPointRate"
//    static let button6HighestSkillPointDifficulty = "button6HighestSkillPointDifficulty"
//    static let button6HighestSkillPointNote = "button6HighestSkillPointNote"
    static let button8SkillPoint = "button8SkillPoint"
//    static let button8HighestSkillPointRate = "button8HighestSkillPointRate"
//    static let button8HighestSkillPointDifficulty = "button8HighestSkillPointDifficulty"
//    static let button8HighestSkillPointNote = "button8HighestSkillPointNote"
    
    ///단일 스킬포인트 계산
    static func skillPoint(difficulty: Int, rate: Double, note: String) -> Double {
        if difficulty == 0 {
            return 0
        }
        var skillPoint: Double
        let e = 2.71828
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
    
    ///현재 데이터베이스로 얻을 수 있는 최대 스킬포인트 계산
    static func maxSkillPoint(button: String) -> Double {
        let results = SongInfo.fetch()
        var max: Double = 0
        var top50Difficulties = [Int]()
        for result in results {
            let buttonResult: SongInfo.Button
            switch button {
            case Buttons.button4:
                buttonResult = result.button4
            case Buttons.button5:
                buttonResult = result.button5
            case Buttons.button6:
                buttonResult = result.button6
            case Buttons.button8:
                buttonResult = result.button8
            default:
                break
            }
            guard let highest = [buttonResult.normal, buttonResult.hard, buttonResult.maximum].sorted().last else { return 0 }
            top50Difficulties.append(highest)
        }
        top50Difficulties.sort(by: >)
        for index in 0..<50 {
            max += Skill.weight(top50Difficulties[index]) * 105
        }
        return max
    }
    
    ///내 기록의 스킬포인트와 1등의 시리즈 계산
    static func mySkillPointAndHighestSeries(button: String) -> (sum: Double, highestSeries: String) {
        func sumAndHighestSeries(_ results: Results<RecordInfo>?, button: String) -> (sum: Double, highestSeries: String) {
            guard let results = results else { return (0, "") }
            var sum: Double = 0
            for index in 0..<50 {
                var skillPoint: Double = 0
                switch button {
                case Buttons.button4:
                    skillPoint = results[index].button4.highestSkillPoint
                case Buttons.button5:
                    skillPoint = results[index].button5.highestSkillPoint
                case Buttons.button6:
                    skillPoint = results[index].button6.highestSkillPoint
                case Buttons.button8:
                    skillPoint = results[index].button8.highestSkillPoint
                default:
                    break
                }
                sum += skillPoint
            }
            switch button {
            case Buttons.button4:
                UserDefaults.standard.set(sum, forKey: Skill.button4SkillPoint)
            case Buttons.button5:
                UserDefaults.standard.set(sum, forKey: Skill.button5SkillPoint)
            case Buttons.button6:
                UserDefaults.standard.set(sum, forKey: Skill.button6SkillPoint)
            case Buttons.button8:
                UserDefaults.standard.set(sum, forKey: Skill.button8SkillPoint)
            default:
                break
            }
            UserDefaults.standard.synchronize()
            return (sum, results.first?.series ?? "")
        }
        let results: Results<RecordInfo>?
        switch button {
        case Buttons.button4:
            results = RecordInfo.fetch().sorted(byKeyPath: "button4.highestSkillPoint")
            return sumAndHighestSeries(results, button: Buttons.button4)
        case Buttons.button5:
            results = RecordInfo.fetch().sorted(byKeyPath: "button5.highestSkillPoint")
            return sumAndHighestSeries(results, button: Buttons.button5)
        case Buttons.button6:
            results = RecordInfo.fetch().sorted(byKeyPath: "button6.highestSkillPoint")
            return sumAndHighestSeries(results, button: Buttons.button6)
        case Buttons.button8:
            results = RecordInfo.fetch().sorted(byKeyPath: "button8.highestSkillPoint")
            return sumAndHighestSeries(results, button: Buttons.button8)
        default:
            return (0, "")
        }
    }
    
    ///스킬포인트 다시 계산하여 데이터베이스 갱신
    static func refresh() {
        let recordResults = RecordInfo.fetch()
        let songResults = SongInfo.fetch()
        for recordResult in recordResults {
            guard let songResult = songResults.filter(key: "localizedTitle", value: recordResult.localizedTitle, method: FilterOperator.equal).first else { return }
            let buttons = ["button4", "button5", "button6", "button8"]
            for button in buttons {
                guard let recordButtonResult = recordResult.value(forKey: button) as? RecordInfo.Button else { return }
                guard let songButtonResult = songResult.value(forKey: button) as? SongInfo.Button else { return }
                let recordNormal = recordButtonResult.normal
                let recordHard = recordButtonResult.hard
                let recordMaximum = recordButtonResult.maximum
                let songNormal = songButtonResult.normal
                let songHard = songButtonResult.hard
                let songMaximum = songButtonResult.maximum
                let normalSkillPoint = Skill.skillPoint(difficulty: songNormal, rate: recordNormal.rate, note: recordNormal.note)
                let hardSkillPoint = Skill.skillPoint(difficulty: songHard, rate: recordHard.rate, note: recordHard.note)
                let maximumSkillPoint = Skill.skillPoint(difficulty: songMaximum, rate: recordMaximum.rate, note: recordMaximum.note)
                guard let maxSkillPoint = [normalSkillPoint, hardSkillPoint, maximumSkillPoint].sorted().last else { return }
                
            }
            
        }
        
        
        
        
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
    
    ///버튼별 현재 스킬레벨의 다음 단계 가져오기
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
    
    ///성과 기록 비율 계산
    static func recordRate(button: String) -> Double {
        var counts = [0, 0]
        let recordResults = RecordInfo.fetch()
        let songResults = SongInfo.fetch()
        
        for result in recordResults {
            let buttonResult: RecordInfo.Button
            let songResult: SongInfo.Button
            guard let filteredSong = songResults.filter(key: "localizedTitle", value: result.localizedTitle, method: FilterOperator.equal).first else { return 0 }
            switch button {
            case Buttons.button4:
                buttonResult = result.button4
                songResult = filteredSong.button4
            case Buttons.button5:
                buttonResult = result.button5
                songResult = filteredSong.button5
            case Buttons.button6:
                buttonResult = result.button6
                songResult = filteredSong.button6
            case Buttons.button8:
                buttonResult = result.button8
                songResult = filteredSong.button8
            default:
                break
            }
            if songResult.normal != 0 {
                counts[0] += 1
            }
            if songResult.hard != 0 {
                counts[0] += 1
            }
            if songResult.maximum != 0 {
                counts[0] += 1
            }
            if buttonResult.normal.rate != 0{
                counts[1] += 1
            }
            if buttonResult.hard.rate != 0{
                counts[1] += 1
            }
            if buttonResult.maximum.rate != 0{
                counts[1] += 1
            }
            let rate = Double(counts[1]) / Double(counts[0])
            return rate
            
        }
    }
}

extension Skill {
    ///4버튼 스킬 레벨 반환
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
    
    ///5버튼 스킬 레벨 반환
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
    
    ///6, 8버튼 스킬 레벨 반환
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
    
    ///스킬포인트 가중치 계산
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
