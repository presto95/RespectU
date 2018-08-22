//
//  MissionResponse.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 21..
//  Copyright © 2018년 Presto. All rights reserved.
//

struct MissionResponse: Codable {
    struct Mission: Codable {
        struct Stage: Codable {
            let title: Language
            let difficulty: String
            let button: String
        }
        let series: String
        let section: String
        let title: String
        let score: Int
        let fever: Int
        let combo: Int
        let rate: Int
        let `break`: Int
        let effector: String
        let reward: Language
        let song1: Stage?
        let song2: Stage?
        let song3: Stage?
        let song4: Stage?
        let song5: Stage?
        let song6: Stage?
    }
    let mission: [Mission]
}
