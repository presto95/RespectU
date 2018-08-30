//
//  RecordResponse.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 28..
//  Copyright © 2018년 Presto. All rights reserved.
//

import Foundation

struct RecordResponse: Codable {
    struct Record: Codable {
        struct Button: Codable {
            struct Difficulty: Codable {
                let rank: String
                let rate: Double
                let note: String
                let skillPoint: Double
            }
            let normal: Difficulty
            let hard: Difficulty
            let maximum: Difficulty
            let highestSkillPoint: Double
            let highestSkillPointDifficulty: String
            let highestSkillPointNote: String
            let highestSillPointRate: Double
        }
        let title: Language
        let button4: Button
        let button5: Button
        let button6: Button
        let button8: Button
        var localizedTitle: String {
            if Locale.current.regionCode == "KR", let korean = title.korean {
                return korean
            } else {
                return title.english
            }
        }
    }
    let uid: String
    let records: [Record]
    let perfectPlays: Int
}
