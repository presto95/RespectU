//
//  User.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 21..
//  Copyright © 2018년 Presto. All rights reserved.
//

struct UserResponse: Codable {
    struct User: Codable {
        struct Record: Codable {
            struct Button: Codable {
                struct Difficulty: Codable {
                    let rank: String
                    let rate: Double
                    let note: String
                    let level: Int
                }
                let normal: Difficulty
                let hard: Difficulty
                let maximum: Difficulty
                let skillPoint: Double
                let highestSkillPointLevel: Int
                let highestSkillPointRate: Double
                let highestSkillPointNote: String
            }
            let title: String
            let lowercase: String
            let series: String
            let button4: Button
            let button5: Button
            let button6: Button
            let button8: Button
        }
        let uid: String
        let nickname: String
        let password: String
        let record: [Record]
    }
    let user: [User]
}
