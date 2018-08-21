//
//  AchievementResponse.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 21..
//  Copyright © 2018년 Presto. All rights reserved.
//

struct AchievementResponse: Codable {
    struct Achievement: Codable {
        let _id: String
        let title: String
        let level: Int
        let type: String
        let item: String
    }
    let achievement: [Achievement]
}
