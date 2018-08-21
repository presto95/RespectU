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
        let _id: String
        let title: String
        let lowercase: String
        let series: String
        let composer: String
        let bpm: String
        let button4: Button
        let button5: Button
        let button6: Button
        let button8: Button
    }
    let song: [Song]
}
