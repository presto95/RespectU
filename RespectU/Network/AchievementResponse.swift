//
//  AchievementResponse.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 21..
//  Copyright © 2018년 Presto. All rights reserved.
//

struct AchievementResponse: Codable {
    struct Achievement: Codable {
        let type: String
        let level: Int
        let section: Language
        let item: Language
    }
    let achievement: [Achievement]
}
