//
//  SongResponse.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 21..
//  Copyright © 2018년 Presto. All rights reserved.
//

import Foundation

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
        var localizedTitle: String {
            if Locale.current.regionCode == "KR", let korean = title.korean {
                return korean
            } else {
                return title.english
            }
        }
        var bpmToString: String {
            if subBpm == 0 {
                return "\(bpm)"
            } else {
                return "\(bpm) ~ \(subBpm ?? 0)"
            }
        }
    }
    let song: [Song]
    var count: Int {
        return song.count
    }
    subscript(index: Int) -> Song {
        return song[index]
    }
}
