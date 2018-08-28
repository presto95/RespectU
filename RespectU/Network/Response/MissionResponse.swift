//
//  MissionResponse.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 21..
//  Copyright © 2018년 Presto. All rights reserved.
//

import Foundation

struct MissionResponse: Codable {
    struct Mission: Codable {
        struct Stage: Codable {
            let title: Language
            let difficulty: String
            let button: String
            var localizedTitle: String {
                if Locale.current.regionCode == "KR", let korean = title.korean {
                    return korean
                } else {
                    return title.english
                }
            }
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
        var localizedReward: String {
            if Locale.current.regionCode == "KR", let korean = reward.korean {
                return korean
            } else {
                return reward.english
            }
        }
    }
    let missions: [Mission]
    var count: Int {
        return missions.count
    }
    subscript(index: Int) -> Mission {
        return missions[index]
    }
}
