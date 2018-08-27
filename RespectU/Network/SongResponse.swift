//
//  SongResponse.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 21..
//  Copyright © 2018년 Presto. All rights reserved.
//

struct SongResponse: Codable {
    struct Song: Codable {
        struct Button: Codable {
            let normal: Int
            let hard: Int
            let maximum: Int
        }
        let title: Language
        let lowercase: Language
        let series: String
        let composer: String
        let bpm: Int
        let subBpm: Int?
        let button4: Button
        let button5: Button
        let button6: Button
        let button8: Button
        var bpmToString: String {
            if subBpm == 0 {
                return "\(bpm)"
            } else {
                return "\(bpm) ~ \(subBpm ?? 0)"
            }
        }
    }
    let song: [Song]
}
