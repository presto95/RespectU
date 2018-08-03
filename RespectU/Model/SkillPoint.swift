//
//  SkillPoint.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 3..
//  Copyright © 2018년 Presto. All rights reserved.
//

import Foundation

class SkillPoint {
    
    private static let button4SkillPoint = "button4SkillPoint"
    private static let button4HighestSkillPointRate = "button4HighestSkillPointRate"
    private static let button4HighestSkillPointDifficulty = "button4HighestSkillPointDifficulty"
    private static let button4HighestSkillPointNote = "button4HighestSkillPointNote"
    private static let button5SkillPoint = "button5SkillPoint"
    private static let button5HighestSkillPointRate = "button5HighestSkillPointRate"
    private static let button5HighestSkillPointDifficulty = "button5HighestSkillPointDifficulty"
    private static let button5HighestSkillPointNote = "button5HighestSkillPointNote"
    private static let button6SkillPoint = "button6SkillPoint"
    private static let button6HighestSkillPointRate = "button6HighestSkillPointRate"
    private static let button6HighestSkillPointDifficulty = "button6HighestSkillPointDifficulty"
    private static let button6HighestSkillPointNote = "button6HighestSkillPointNote"
    private static let button8SkillPoint = "button8SkillPoint"
    private static let button8HighestSkillPointRate = "button8HighestSkillPointRate"
    private static let button8HighestSkillPointDifficulty = "button8HighestSkillPointDifficulty"
    private static let button8HighestSkillPointNote = "button8HighestSkillPointNote"
    
    static func skillPoint(difficulty: Int, rate: String, note: String) -> Double {
        if difficulty == 0 {
            return 0
        }
        var skillPoint: Double
        let e = 2.71828
        let rate = Double(rate.split(separator: "%").first?.description ?? "") ?? 0
        let weight = SkillPoint.weight(difficulty)
        if rate >= 80 {
            let temp = pow((rate - 80) / 20.0, e) + 1
            skillPoint = weight * 50 * temp
        } else {
            skillPoint = Double(weight * rate * 5.0) / 8.0
        }
        if note == "-" {
            skillPoint *= 0.9
        } else if note == Result.perfectPlay {
            skillPoint *= 1.05
        }
        skillPoint = (skillPoint * 100).rounded() / 100
        return skillPoint
    }
    
    static func refresh() {
        let results = RecordInfo.get()
        for result in results {
            let normalButton4SkillPoint = SkillPoint.skillPoint(difficulty: result.nm4, rate: result.nm4Rate, note: result.nm4Note)
            let hardButton4SkillPoint = SkillPoint.skillPoint(difficulty: result.hd4, rate: result.hd4Rate, note: result.hd4Note)
            let maximumButton4SkillPoint = SkillPoint.skillPoint(difficulty: result.mx4, rate: result.mx4Rate, note: result.mx4Note)
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
            let normalButton5SkillPoint = SkillPoint.skillPoint(difficulty: result.nm5, rate: result.nm5Rate, note: result.nm5Note)
            let hardButton5SkillPoint = SkillPoint.skillPoint(difficulty: result.hd5, rate: result.hd5Rate, note: result.hd5Note)
            let maximumButton5SkillPoint = SkillPoint.skillPoint(difficulty: result.mx5, rate: result.mx5Rate, note: result.mx5Note)
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
            let normalButton6SkillPoint = SkillPoint.skillPoint(difficulty: result.nm6, rate: result.nm6Rate, note: result.nm6Note)
            let hardButton6SkillPoint = SkillPoint.skillPoint(difficulty: result.hd6, rate: result.hd6Rate, note: result.hd6Note)
            let maximumButton6SkillPoint = SkillPoint.skillPoint(difficulty: result.mx6, rate: result.mx6Rate, note: result.mx6Note)
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
            let normalButton8SkillPoint = SkillPoint.skillPoint(difficulty: result.nm8, rate: result.nm8Rate, note: result.nm8Note)
            let hardButton8SkillPoint = SkillPoint.skillPoint(difficulty: result.hd8, rate: result.hd8Rate, note: result.hd8Note)
            let maximumButton8SkillPoint = SkillPoint.skillPoint(difficulty: result.mx8, rate: result.mx8Rate, note: result.mx8Note)
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
