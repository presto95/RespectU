//
//  AchievementResponse.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 21..
//  Copyright © 2018년 Presto. All rights reserved.
//

import Foundation

struct AchievementResponse: Codable {
    struct Achievement: Codable {
        let type: String
        let level: Int
        let section: LanguageResponse
        let item: LanguageResponse
        var localizedSection: String {
            if Locale.current.regionCode == "KR", let korean = section.korean {
                return korean
            } else {
                return section.english
            }
        }
        var localizedItem: String {
            if Locale.current.regionCode == "KR", let korean = item.korean {
                return korean
            } else {
                return item.english
            }
        }
    }
    let achievements: [Achievement]
    var count: Int {
        return achievements.count
    }
    subscript(index: Int) -> Achievement {
        return achievements[index]
    }
}
