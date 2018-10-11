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
        let title: LanguageResponse
        let lowercase: LanguageResponse
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
        var localizedLowercase: String {
            if Locale.current.regionCode == "KR", let korean = lowercase.korean {
                return korean
            } else {
                return lowercase.english
            }
        }
        var bpmToString: String {
            if let subBpm = subBpm {
                return "BPM \(bpm) ~ \(subBpm)"
            } else {
                return "BPM \(bpm)"
            }
        }
    }
    let songs: [Song]
    var count: Int {
        return songs.count
    }
    subscript(index: Int) -> Song {
        return songs[index]
    }
}
